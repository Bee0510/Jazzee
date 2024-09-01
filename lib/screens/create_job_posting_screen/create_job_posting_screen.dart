// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jazzee/backend/getdata/get_location.dart';
import 'package:jazzee/backend/getdata/get_personal_info.dart';
import 'package:jazzee/backend/jobdata/send_Job_openning.dart';
import 'package:jazzee/components/button.dart';
import 'package:jazzee/components/text_field.dart';
import 'package:jazzee/constants.dart/constants.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/notification/send_notification.dart';
import 'package:jazzee/screens/create_job_posting_screen/widgets/date_picker.dart';
import 'package:jazzee/screens/create_job_posting_screen/widgets/skill_picker.dart';
import 'package:jazzee/screens/wrapper.dart';

import '../../backend/getdata/get_all_collage.dart';
import '../../components/basic_text.dart';
import '../../core/theme/base_color.dart';
import '../../models/college/college_model.dart';
import '../../models/location_model.dart';
import '../../models/recruiter/recruiter_model.dart';

class createJobPostingScreen extends StatefulWidget {
  @override
  _createJobPostingScreenState createState() => _createJobPostingScreenState();
}

class _createJobPostingScreenState extends State<createJobPostingScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedJobType;
  String? _selectedCollageName;
  String _selectedCollageId = '';
  List<String> selectedSkills = [];
  String? _selectedJobLocation;
  List<Map<String, dynamic>> filteredCollages = [];

  bool isCollageSpecific = false;
  late Future<List<Map<String, dynamic>>> collages;
  late Future<List<Locations>> locations;
  late Future<Recruiter> recruiter;

  final List<String> skillsList = ['Flutter', 'Dart', 'Java', 'Python', 'SQL'];
  final List<String> collagesList = ['Collage A', 'Collage B', 'Collage C'];
  final List<String> jobTypes = ['Remote', 'Hybrid', 'On-site'];

  TextEditingController jobTitleController = TextEditingController();
  TextEditingController jobDescriptionController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController applyTillDateController = TextEditingController();
  TextEditingController openingsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    collages = getAllCollage().get_all_collage();
    locations = GetLocation().GetCompanyLocation(supabase.auth.currentUser!.id);
    recruiter = GetPersonalInfo().GetCompanyInfo(supabase.auth.currentUser!.id);
  }

  void filterSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredCollages = [...filteredCollages];
      });
    } else {
      setState(() {
        filteredCollages = filteredCollages
            .where((collage) => collage['Collage Name']
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  Future<void> _refresh() async {
    setState(() {
      collages = getAllCollage().get_all_collage();
      locations =
          GetLocation().GetCompanyLocation(supabase.auth.currentUser!.id);
      recruiter =
          GetPersonalInfo().GetCompanyInfo(supabase.auth.currentUser!.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'Add Job Posting',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        automaticallyImplyLeading: true,
        centerTitle: true,
        actions: [],
      ),
      body: FutureBuilder(
        future: Future.wait([collages, locations, recruiter]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Column(
              children: [
                CircularProgressIndicator(),
                Text('Fetching Institute Details. Please Wait')
              ],
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No Address available'));
          } else {
            final List<Map<String, dynamic>> data = snapshot.data[0];
            final List<Locations> locationData = snapshot.data[1];
            final List<String> locationList = locationData
                .map((location) => location.city + ', ' + location.state)
                .toSet()
                .toList();
            final Recruiter recruiter = snapshot.data[2];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      text_box(
                          value: jobTitleController,
                          title: 'Job',
                          hint: 'Job Title'),
                      SizedBox(height: 16),
                      Container(
                        child: TextField(
                          controller: jobDescriptionController,
                          minLines: 1,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle:
                                TextStyle(color: AppColors.primarycolor2),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.primarycolor2)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.primarycolor2),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          hintText: '-- Select Skills Required ---',
                          hintStyle: TextStyle(
                              fontFamily: 'Roboto', color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primarycolor2),
                          ),
                        ),
                        items: skillsList.map((String skill) {
                          return DropdownMenuItem<String>(
                            value: skill,
                            child: Text(skill),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null &&
                              !selectedSkills.contains(value)) {
                            setState(() {
                              selectedSkills.add(value);
                            });
                          }
                        },
                      ),
                      SizedBox(height: 8),
                      SkillsSection(skillsList: selectedSkills),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Organisation Specific',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                          Checkbox(
                            value: isCollageSpecific,
                            activeColor: AppColors.black,
                            onChanged: (bool? value) {
                              setState(() {
                                isCollageSpecific = value ?? false;
                              });
                            },
                          ),
                        ],
                      ),
                      if (isCollageSpecific)
                        Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12, width: 1),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: DropdownButtonFormField<String>(
                            value: _selectedCollageName,
                            isExpanded: true,
                            decoration: InputDecoration(
                              hintText: '-- Select organisation ---',
                              hintStyle: TextStyle(
                                  fontFamily: 'Roboto', color: Colors.grey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedCollageName = newValue!;
                                _selectedCollageId = data.firstWhere(
                                    (element) =>
                                        element['Collage Name'] ==
                                        newValue)['Collage ID'];
                                print(_selectedCollageId);
                                print(_selectedCollageName);
                              });
                            },
                            items: data.map((e) {
                              return DropdownMenuItem<String>(
                                value: e['Collage Name'],
                                child: Text(e['Collage Name']),
                              );
                            }).toList(),
                          ),
                        ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: selectedJobType,
                              decoration: InputDecoration(
                                hintText: '-- Select Job Type ---',
                                hintStyle: TextStyle(
                                    fontFamily: 'Roboto', color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primarycolor2),
                                ),
                              ),
                              items: jobTypes.map((String jobType) {
                                return DropdownMenuItem<String>(
                                  value: jobType,
                                  child: Text(jobType),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedJobType = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: text_box(
                              value: openingsController,
                              title: '',
                              keyboard: TextInputType.number,
                              hint: 'Total Openings',
                              validator: (value) {
                                if (value!.isEmpty || value == '0') {
                                  return 'Openings should be greater than 0';
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: _selectedJobLocation,
                        decoration: InputDecoration(
                          hintText: '-- Select Job Location ---',
                          hintStyle: TextStyle(
                              fontFamily: 'Roboto', color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primarycolor2),
                          ),
                        ),
                        items: locationList.map((String jobType) {
                          return DropdownMenuItem<String>(
                            value: jobType,
                            child: Text(jobType),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedJobLocation = value;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      text_box(
                        value: salaryController,
                        title: '',
                        hint: 'Salary per annum',
                        keyboard: TextInputType.number,
                      ),
                      SizedBox(height: 16),
                      tillDatePicker(),
                      SizedBox(height: 16),
                      SizedBox(height: 40),
                      Button(
                        onPressed: () async {
                          if (_formKey.currentState!.validate() &&
                              selectedSkills.isNotEmpty &&
                              selectedJobType != null &&
                              _selectedJobLocation != null &&
                              selectedStartDate != null) {
                            if (isCollageSpecific &&
                                _selectedCollageId.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Please select a collage'),
                              ));
                            } else {
                              await SendJobPostingInfo()
                                  .sendJobOpenings(
                                      supabase.auth.currentUser!.id,
                                      jobTitleController.text,
                                      selectedJobType ?? '',
                                      salaryController.text,
                                      isCollageSpecific
                                          ? _selectedCollageId
                                          : '',
                                      jobDescriptionController.text,
                                      selectedSkills.join(', '),
                                      openingsController.text,
                                      _selectedJobLocation!,
                                      recruiter.companyName,
                                      selectedStartDate!)
                                  .then((value) async {
                                await sendPushMessage(
                                    recruiter.token,
                                    'Job Creation Successful',
                                    'Your Job Posting has been created successfully');
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 1),
                                  content: Text('Job Posting Created'),
                                ));
                                navigatorKey.currentState!.pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => wrapper()),
                                    (route) => false);
                              });
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Please fill all the fields'),
                            ));
                          }
                        },
                        color: AppColors.black,
                        text: 'Create Job Posting',
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
