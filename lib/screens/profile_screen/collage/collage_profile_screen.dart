// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jazzee/backend/getdata/get_personal_info.dart';
import 'package:jazzee/models/college/college_model.dart';
import 'package:jazzee/models/location_model.dart';
import 'package:jazzee/models/student/student_model.dart';
import 'package:jazzee/screens/add_location_screen/add_location_screen.dart';
import 'package:jazzee/screens/collage_company_screen/collage_company_screen.dart';
import 'package:jazzee/screens/personal_info_screen/personal_info_screen.dart';
import 'package:jazzee/screens/profile_screen/collage/widgets/college_students_screen.dart';

import '../../../backend/getdata/get_location.dart';
import '../../../components/basic_text.dart';
import '../../../constants.dart/constants.dart';
import '../../../core/theme/base_color.dart';
import '../../../core/theme/base_font';
import '../../../main.dart';
import '../../wrapper.dart';

class collageProfileScreen extends StatefulWidget {
  const collageProfileScreen({Key? key, required this.collage})
      : super(key: key);
  final collage;
  @override
  State<collageProfileScreen> createState() => _collageProfileScreenState();
}

class _collageProfileScreenState extends State<collageProfileScreen> {
  late Future<Collage> futureCollageResponse;
  late Future<List<Student>> futureCollageStudentResponse;
  late Future<Locations> futureLocationResponse;

  @override
  void initState() {
    futureCollageResponse = GetPersonalInfo().GetCollageInfo();
    futureCollageStudentResponse = GetPersonalInfo().GetCollageStudent();
    futureLocationResponse =
        GetLocation().GetUserLocation(widget.collage.collageId);
    super.initState();
  }

  Future<void> _refresh() async {
    setState(() {
      futureCollageResponse = GetPersonalInfo().GetCollageInfo();
      futureCollageStudentResponse = GetPersonalInfo().GetCollageStudent();
      futureLocationResponse =
          GetLocation().GetUserLocation(widget.collage.collageId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'College Profile',
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
          future: Future.wait([
            futureCollageResponse,
            futureCollageStudentResponse,
            futureLocationResponse
          ]),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No data found'));
            } else {
              Collage college = snapshot.data[0];
              List<Student> students = snapshot.data[1];
              Locations location = snapshot.data[2];
              final studentsPlaced = students
                  .where((element) => element.placedOnCampus == true)
                  .toList()
                  .length;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Color(Random().nextInt(0xffffffff)),
                          child: Text(
                            college.collageName[0],
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        college.collageName + '-' + college.collageCode,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "College ID: ${college.collageId}",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      college.coordinatorName != ''
                          ? Text(
                              "Coordinator: ${college.coordinatorName}",
                              style: TextStyle(fontSize: 14),
                            )
                          : Container(),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.mail),
                          SizedBox(width: 8),
                          Text(college.collageMail),
                        ],
                      ),
                      SizedBox(height: 8),
                      college.collageNo == ''
                          ? Container()
                          : Row(
                              children: [
                                Icon(Icons.phone),
                                SizedBox(width: 8),
                                Text(college.collageNo),
                              ],
                            ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          SizedBox(width: 8),
                          location != null
                              ? Text(
                                  location.address1 +
                                      ', ' +
                                      location.address2! +
                                      ', ' +
                                      location.city +
                                      ', ' +
                                      location.state +
                                      ', ' +
                                      location.country +
                                      '- ' +
                                      location.pinCode,
                                  style: TextStyle(overflow: TextOverflow.clip),
                                )
                              : InkWell(
                                  onTap: () async {
                                    final result =
                                        await navigatorKey.currentState!.push(
                                      MaterialPageRoute(
                                        builder: (context) => addLocationScreen(
                                          userId: college.collageId,
                                        ),
                                      ),
                                    );
                                    if (result == 'refresh') {
                                      _refresh();
                                    }
                                  },
                                  child: Text(
                                    'Add Location',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(height: 8),
                      college.websiteLink == ''
                          ? Container()
                          : Row(
                              children: [
                                Icon(Icons.link),
                                SizedBox(width: 8),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    college.websiteLink,
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildInfoCard("Enrolled", students.length),
                          _buildInfoCard("Placed", studentsPlaced),
                        ],
                      ),
                      SizedBox(height: 16),
                      _buildListTile(
                          'Student Information',
                          Icons.person,
                          studentSearchPage(
                            students: students,
                          )),
                      SizedBox(height: 16),
                      _buildListTile('Companies', Icons.factory,
                          collegeCompanyJobScreen(userId: college.collageId)),
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
