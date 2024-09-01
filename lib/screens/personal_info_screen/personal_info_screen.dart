// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jazzee/core/utils/shared_preference.dart';
import 'package:jazzee/models/student/education_model.dart';
import 'package:jazzee/models/student/projects_model.dart';
import 'package:jazzee/models/student/skills_model.dart';
import 'package:jazzee/models/student/student_model.dart';
import 'package:jazzee/models/student/work_experience.dart';
import 'package:jazzee/screens/personal_info_screen/widgets/components/projects_component.dart';
import 'package:jazzee/screens/personal_info_screen/widgets/components/skills_component.dart';
import 'package:jazzee/screens/personal_info_screen/widgets/components/work_experience_component.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../components/basic_text.dart';
import '../../../../core/theme/base_color.dart';
import '../../backend/getdata/get_personal_info.dart';
import '../../main.dart';
import 'widgets/components/education_component.dart';
import 'widgets/education_section.dart';
import 'widgets/personal_details.dart';
import 'widgets/portfolio_section.dart';
import 'widgets/project_section.dart';
import 'widgets/skills_section.dart';
import 'widgets/work_experience_section.dart';

int analysis = 0;
int educatio = 0;
int work = 0;
int project = 0;
int skill = 0;

class personalInfoScreen extends StatefulWidget {
  const personalInfoScreen({Key? key, this.user}) : super(key: key);
  final Student? user;
  @override
  State<personalInfoScreen> createState() => _personalInfoScreenState();
}

class _personalInfoScreenState extends State<personalInfoScreen> {
  late Future<List<Education>> futureEducationResponse;
  late Future<List<Skill>> futureSkillResponse;
  late Future<List<WorkExperience>> futureWorkExpResponse;
  late Future<List<Projects>> futureProjectsResponse;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    setState(() {
      futureEducationResponse = GetPersonalInfo().GetUserEducation();
      futureSkillResponse = GetPersonalInfo().GetUserSkills();
      futureWorkExpResponse = GetPersonalInfo().GetUserWorkExperience();
      futureProjectsResponse = GetPersonalInfo().GetUserProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'Resume',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        actions: [],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder(
              future: Future.wait([
                futureEducationResponse,
                futureSkillResponse,
                futureWorkExpResponse,
                futureProjectsResponse
              ]),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('No data found'));
                } else {
                  final List<Education> education = snapshot.data[0];
                  final List<Skill> skills = snapshot.data[1];
                  final List<WorkExperience> workExperience = snapshot.data[2];
                  final List<Projects> projects = snapshot.data[3];
                  education.isEmpty ? educatio = 0 : educatio = 1;
                  skills.isEmpty ? skill = 0 : skill = 1;
                  workExperience.isEmpty ? work = 0 : work = 1;
                  projects.isEmpty ? project = 0 : project = 1;
                  analysis = educatio + skill + work + project;
                  SharedPreferencesService.setString(
                      'analysis', analysis.toString());
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PersonalDetailsSection(
                        user: widget.user,
                      ),
                      Divider(),
                      EducationSection(educationList: education),
                      TextButton(
                        onPressed: () async {
                          final result = await navigatorKey.currentState!
                              .push(MaterialPageRoute(builder: (context) {
                            return educationComponent();
                          }));
                          if (result == 'refresh') {
                            _refresh();
                          }
                        },
                        child: Text('+ Add education',
                            style: TextStyle(color: Colors.blue)),
                      ),
                      Divider(),
                      WorkExperienceSection(
                        workexperienceList: workExperience,
                      ),
                      TextButton(
                        onPressed: () async {
                          final result = await navigatorKey.currentState!.push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      workExperienceComponent()));
                          if (result == 'refresh') {
                            _refresh();
                          }
                        },
                        child: Text('+ Add Work Experience',
                            style: TextStyle(color: Colors.blue)),
                      ),
                      Divider(),
                      ProjectsSection(projectList: projects),
                      TextButton(
                        onPressed: () async {
                          final result = await navigatorKey.currentState!.push(
                              MaterialPageRoute(
                                  builder: (context) => projectsComponent()));
                          if (result == 'refresh') {
                            _refresh();
                          }
                        },
                        child: Text('+ Add Projects/Certificates',
                            style: TextStyle(color: Colors.blue)),
                      ),
                      Divider(),
                      SkillsSection(
                        skillsList: skills,
                      ),
                      TextButton(
                        onPressed: () async {
                          final result = await navigatorKey.currentState!.push(
                              MaterialPageRoute(
                                  builder: (context) => skillsComponent()));
                          if (result == 'refresh') {
                            _refresh();
                          }
                        },
                        child: Text('+ Add skill',
                            style: TextStyle(color: Colors.blue)),
                      ),
                      Divider(),
                      PortfolioSection(),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
