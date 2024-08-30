// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:jazzee/backend/getdata/get_personal_info.dart';
import 'package:jazzee/models/location_model.dart';
import 'package:jazzee/models/recruiter/recruiter_model.dart';
import 'package:jazzee/screens/add_location_screen/add_location_screen.dart';
import 'package:jazzee/screens/profile_screen/recuiter/widgets/company_job.dart';
import 'package:jazzee/screens/profile_screen/recuiter/widgets/company_location.dart';
import '../../../backend/getdata/get_location.dart';
import '../../../components/basic_text.dart';
import '../../../constants.dart/constants.dart';
import '../../../core/theme/base_color.dart';
import '../../../core/theme/base_font';
import '../../../main.dart';
import '../../wrapper.dart';

class companyProfileScreen extends StatefulWidget {
  const companyProfileScreen({Key? key, required this.recruiter})
      : super(key: key);
  final Recruiter recruiter;
  @override
  State<companyProfileScreen> createState() => _companyProfileScreenState();
}

class _companyProfileScreenState extends State<companyProfileScreen> {
  late Future<Recruiter> futureCompanyResponse;
  late Future<Locations> futureLocationResponse;

  @override
  void initState() {
    futureCompanyResponse =
        GetPersonalInfo().GetCompanyInfo(widget.recruiter.companyId);
    futureLocationResponse =
        GetLocation().GetUserLocation(widget.recruiter.companyId);
    super.initState();
  }

  Future<void> _refresh() async {
    setState(() {
      futureCompanyResponse =
          GetPersonalInfo().GetCompanyInfo(widget.recruiter.companyId);
      futureLocationResponse =
          GetLocation().GetUserLocation(widget.recruiter.companyId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'Company Profile',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        automaticallyImplyLeading: true,
        centerTitle: true,
        actions: [],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder(
          future: Future.wait([futureCompanyResponse, futureLocationResponse]),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No data found'));
            } else {
              Recruiter company = snapshot.data[0];
              Locations location = snapshot.data[1];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/image/google_logo.png'),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        company.companyName,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "College ID: ${company.companyId}",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.mail),
                          SizedBox(width: 8),
                          Text(company.companyEmail!),
                        ],
                      ),
                      SizedBox(height: 8),
                      company.companyTelephone == ''
                          ? Container()
                          : Row(
                              children: [
                                Icon(Icons.phone),
                                SizedBox(width: 8),
                                Text(company.companyTelephone!),
                              ],
                            ),
                      SizedBox(height: 8),
                      company.link == ''
                          ? Container()
                          : Row(
                              children: [
                                Icon(Icons.link),
                                SizedBox(width: 8),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    company.link,
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // _buildInfoCard("Enrolled", students.length),
                          // _buildInfoCard("Placed", studentsPlaced),
                        ],
                      ),
                      SizedBox(height: 16),
                      _buildListTile('Company Locations', Icons.maps_home_work,
                          companyLocations(user: company.companyId)),
                      SizedBox(height: 16),
                      _buildListTile(
                          'Job Postings',
                          Icons.work,
                          companyJobScreen(
                            userId: widget.recruiter.companyId,
                          )),
                      SizedBox(height: 16),
                      _buildListTile('Log Out', Icons.power_settings_new, null),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, int value) {
    return Card(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                value.toString(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, Widget? route) {
    return InkWell(
      onTap: () async {
        if (route != null) {
          navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (context) => route,
            ),
          );
        } else {
          await supabase.auth.signOut().then((value) {
            navigatorKey.currentState!.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => wrapper()),
                (route) => false);
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: AppColors.black,
          ),
          title: Text(
            title,
            style: AppTextStyles.smallBold,
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
