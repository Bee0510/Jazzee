// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:jazzee/backend/getdata/get_job_postings.dart';
import 'package:jazzee/backend/jobdata/send_job_saved.dart';
import 'package:jazzee/constants.dart/constants.dart';
import 'package:jazzee/core/theme/base_color.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/models/recruiter/jobs_posting_model.dart';
import 'package:jazzee/models/student/job_saved_model.dart';
import 'package:jazzee/models/student/student_model.dart';
import '../../../models/student/skills_model.dart';
import '../../job_detailed_screen/job_detailed_screen.dart';

class JobCard extends StatefulWidget {
  final JobPosting job;
  final bool isRecommended;
  final List<String> skills;
  final List<String> savedJob;

  final Student student;
  const JobCard(
      {Key? key,
      required this.job,
      required this.isRecommended,
      required this.skills,
      required this.student,
      required this.savedJob})
      : super(key: key);

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  late Future<List<JobSaved>> futureSavedResonse;
  late Set<String> selectedJobs;
  @override
  void initState() {
    selectedJobs = widget.savedJob.toSet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedJobs.contains(widget.job.jobId);
    List<String> company_skill = widget.job.jobSkills.split(',');
    List<String> matchingElements = company_skill
        .where((element) => widget.skills.contains(element))
        .toList();

    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.black),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                widget.job.jobRole,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              widget.isRecommended
                  ? SizedBox(width: MediaQuery.of(context).size.width * 0.45)
                  : Container(),
              InkWell(
                child: Icon(
                  isSelected ? Icons.bookmark : Icons.bookmark_outline,
                  color: isSelected ? AppColors.black : Colors.grey,
                ),
                onTap: () async {
                  if (isSelected) {
                    await supabase
                        .from('job_saved_s')
                        .delete()
                        .eq('job_id', widget.job.jobId)
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Removed From Saved Jobs'),
                      ));
                      // setState(() {
                      //   isSelected = false;
                      // });
                    });
                  } else {
                    await SendJobSavedInfo()
                        .sendJobSaved(
                            widget.job.companyId,
                            widget.job.jobId,
                            widget.job.jobRole,
                            widget.job.jobType!,
                            widget.job.salary!,
                            widget.job.isSpecific,
                            widget.job.jobDescription!,
                            widget.job.jobSkills,
                            widget.job.totalOpening,
                            widget.job.jobLocation,
                            widget.job.companyName,
                            widget.job.applyTill!,
                            widget.student.studentId)
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Added To Saved Jobs'),
                      ));
                    });
                  }
                  setState(() {
                    if (isSelected) {
                      selectedJobs.remove(widget.job.jobId);
                    } else {
                      selectedJobs.add(widget.job.jobId);
                    }
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 4),
          // Location
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.job.jobLocation,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              SizedBox(width: 4),
              JobTag(label: widget.job.jobType!),
              if (widget.job.jobType == 'Remote') JobTag(label: 'Remote'),
            ],
          ),
          Divider(),
          matchingElements.length == 0
              ? Container()
              : GestureDetector(
                  onTap: () {},
                  child: Text(
                    '${matchingElements.length} Skill Matches your profile',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ),
          SizedBox(height: 8),
          widget.job.applyTill!.isEmpty
              ? Container()
              : Text(
                  'Apply By ${widget.job.applyTill}',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),

          SizedBox(height: 8),
          Text(
            '₹' + widget.job.salary! + ' /year',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          InkWell(
            onTap: () {
              navigatorKey.currentState!.push(MaterialPageRoute(
                  builder: (context) => jobDetailsScreen(
                        job: widget.job,
                        student: widget.student,
                      )));
            },
            child: Text(
              'Job Details',
              style: TextStyle(
                  color: AppColors.primarycolor2, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}

class JobTag extends StatelessWidget {
  final String label;

  const JobTag({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
    );
  }
}
