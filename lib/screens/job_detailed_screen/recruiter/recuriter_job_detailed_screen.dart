// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:jazzee/constants.dart/constants.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/models/recruiter/jobs_posting_model.dart';

import '../../../../components/basic_text.dart';
import '../../../../core/theme/base_color.dart';
import '../../../components/button.dart';

class CompanyJobDetailsScreen extends StatefulWidget {
  const CompanyJobDetailsScreen({Key? key, required this.job})
      : super(key: key);
  final JobPosting job;
  @override
  State<CompanyJobDetailsScreen> createState() =>
      _CompanyJobDetailsScreenState();
}

class _CompanyJobDetailsScreenState extends State<CompanyJobDetailsScreen> {
  late List<String> skillList;
  @override
  void initState() {
    skillList = widget.job.jobSkills.split(',');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.black,
          title: basic_text(
              title: 'Job Details',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500)),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.white)),
          centerTitle: true,
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Actively hiring',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            widget.job.jobRole,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: Colors.grey, size: 16),
                              SizedBox(width: 4),
                              Text(widget.job.jobLocation,
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.monetization_on,
                                  color: Colors.grey, size: 16),
                              SizedBox(width: 4),
                              Text('₹ ${widget.job.salary}/Year',
                                  style: TextStyle(color: Colors.grey)),
                              SizedBox(width: 10),
                            ],
                          ),
                          widget.job.applyTill!.isEmpty
                              ? Container()
                              : Row(
                                  children: [
                                    Icon(Icons.date_range,
                                        color: Colors.grey, size: 16),
                                    SizedBox(width: 4),
                                    Text('Apply by ${widget.job.applyTill}',
                                        style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/image/google_logo.png',
                      height: 50,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Job Description',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  widget.job.jobDescription!,
                  style: TextStyle(color: Colors.grey[800]),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.link, color: Colors.blue),
                    SizedBox(width: 4),
                    Text('Website', style: TextStyle(color: Colors.blue)),
                  ],
                ),
                SizedBox(height: 24),
                Text(
                  'Skills Required',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SkillsComponent(skillsList: skillList),
                SizedBox(height: 10),
                Wrap(
                  spacing: 8.0,
                  children: [
                    Chip(
                      label: Text('Flexible work hours'),
                      backgroundColor: Colors.grey[200],
                    ),
                    Chip(
                      label: Text('5 days a week'),
                      backgroundColor: Colors.grey[200],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Text(
                  'Number of openings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  widget.job.totalOpening,
                  style: TextStyle(color: Colors.grey[800]),
                ),
                SizedBox(height: 24),
                Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '1. A bachelor\'s or master\'s degree in mechanical engineering or a related field.\n'
                  '2. Good experience or coursework in Solidworks or Ansys.\n'
                  '3. Good knowledge of motor technology, machine design, and vehicle dynamics.\n'
                  '4. Interest in the electric vehicle or automotive industry and a desire to learn about designing and analyzing mechanical systems for EVs.\n'
                  '5. Strong communication and presentation skills, with the ability to learn and explain technical concepts clearly.\n'
                  '6. A proactive attitude with a passion for learning and development.\n'
                  '7. Ability to work collaboratively in a team-oriented environment.',
                  style: TextStyle(color: Colors.grey[800]),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
        bottomNavigationBar: role_type == 'collage'
            ? null
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Button(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Are you sure you want to cancel this job?',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('No'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await supabase
                                      .from('job_postings')
                                      .delete()
                                      .eq('job_id', widget.job.jobId)
                                      .then((value) {
                                    navigatorKey.currentState!.pop();
                                    navigatorKey.currentState!.pop('refresh');
                                  });
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          );
                        });
                  },
                  color: AppColors.black,
                  text: 'Cancel Job',
                  minimumSize: Size(double.infinity, 50),
                ),
              ));
  }
}

class SkillsComponent extends StatefulWidget {
  const SkillsComponent({Key? key, required this.skillsList}) : super(key: key);
  final List<String> skillsList;
  @override
  State<SkillsComponent> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsComponent> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: widget.skillsList.map((skill) {
        return Chip(
          label: Text(skill),
          labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        );
      }).toList(),
    );
  }
}
