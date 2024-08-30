import 'package:flutter/material.dart';
import 'package:jazzee/components/skeletal_text.dart';
import 'package:jazzee/core/theme/base_color.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/models/recruiter/jobs_posting_model.dart';
import 'package:jazzee/screens/job_applicants_screen.dart/job_applicants_screen.dart';
import 'package:jazzee/screens/profile_screen/collage/widgets/college_students_screen.dart';

import '../../../backend/getdata/get_applicants.dart';
import '../../../models/student/student_model.dart';

class CompanysavedJobCard extends StatefulWidget {
  final JobPosting job;

  const CompanysavedJobCard({
    Key? key,
    required this.job,
  }) : super(key: key);

  @override
  State<CompanysavedJobCard> createState() => _CompanysavedJobCardState();
}

class _CompanysavedJobCardState extends State<CompanysavedJobCard> {
  late Future<List<Student>> student;
  @override
  void initState() {
    super.initState();
    student = GetApplicants().GetApplicant(widget.job.jobId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: student,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SkeletonLoader(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error fetching applicants'),
          );
        } else if (snapshot.hasData) {
          final List<Student> students = snapshot.data;
          return Container(
            margin: EdgeInsets.only(bottom: 16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.job.jobRole,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  '₹' + widget.job.salary!,
                  style: TextStyle(
                      color: AppColors.green, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      widget.job.jobLocation,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(width: 5),
                    Text(
                      '• ${widget.job.jobType}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                // Posted Time
                Text(
                  widget.job.applyTill!,
                  style: TextStyle(color: Colors.grey),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        navigatorKey.currentState!.push(
                          MaterialPageRoute(
                            builder: (context) => jobApplicantsScreen(
                              students: students,
                              jobId: widget.job.jobId,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Applications',
                        style: TextStyle(
                          color: AppColors.primarycolor2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    InkWell(
                      onTap: () async {
                        jobApplicantsScreen(
                          students: students,
                          jobId: widget.job.jobId,
                        );
                      },
                      child: const Text(
                        'Details',
                        style: TextStyle(
                          color: AppColors.primarycolor2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('No applicants found'),
          );
        }
      },
    );
  }
}
