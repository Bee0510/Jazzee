// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:jazzee/models/student/job_applied_model.dart';
import 'package:jazzee/models/student/student_model.dart';
import '../../../../components/basic_text.dart';
import '../../../../core/theme/base_color.dart';

class appliedJobDetailsScreen extends StatefulWidget {
  const appliedJobDetailsScreen({Key? key, this.job, required this.student})
      : super(key: key);
  final JobApplied? job;
  final Student student;
  @override
  State<appliedJobDetailsScreen> createState() =>
      _appliedJobDetailsScreenState();
}

class _appliedJobDetailsScreenState extends State<appliedJobDetailsScreen> {
  late List<String> skillList;
  bool isLoading = false;
  @override
  void initState() {
    skillList = widget.job!.jobSkills.split(',');
    super.initState();
  }

  String getStatus(bool isAccepted, bool isInterviewed, bool isSelected) {
    if (isAccepted && isInterviewed && isSelected) {
      return 'Selected';
    } else if (isAccepted && isInterviewed && !isSelected) {
      return 'Interviewed but not selected';
    } else if (isAccepted && !isInterviewed && !isSelected) {
      return 'Accepted but not interviewed';
    } else if (!isAccepted && isInterviewed && isSelected) {
      return 'Interviewed and selected';
    } else if (!isAccepted && isInterviewed && !isSelected) {
      return 'Interviewed';
    } else if (!isAccepted && !isInterviewed && !isSelected) {
      return 'Pending';
    } else if (isAccepted && !isInterviewed && isSelected) {
      return 'Selected without interview';
    } else {
      return 'Unknown Status';
    }
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
                            widget.job!.jobRole,
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
                              Text(widget.job!.jobLocation,
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.attach_money,
                                  color: Colors.grey, size: 16),
                              SizedBox(width: 4),
                              Text('₹ ${widget.job!.salary}/Year',
                                  style: TextStyle(color: Colors.grey)),
                              SizedBox(width: 10),
                            ],
                          ),
                          widget.job!.applyTill!.isEmpty
                              ? Container()
                              : Row(
                                  children: [
                                    Icon(Icons.date_range,
                                        color: Colors.grey, size: 16),
                                    SizedBox(width: 4),
                                    Text('Apply by ${widget.job!.applyTill}',
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
                  widget.job!.jobDescription!,
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
                  widget.job!.totalOpening,
                  style: TextStyle(color: Colors.grey[800]),
                ),
                SizedBox(height: 8),
                Text(
                  'Applied on ${widget.job!.applied_on}',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.black,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'status:',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 6),
              Text(
                getStatus(widget.job!.is_accepted, widget.job!.is_interview,
                    widget.job!.is_selected),
                style: TextStyle(
                    color: AppColors.primarycolor2,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ],
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
