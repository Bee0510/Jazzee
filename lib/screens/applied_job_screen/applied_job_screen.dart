// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:jazzee/backend/getdata/get_job_postings.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/models/recruiter/jobs_posting_model.dart';
import 'package:jazzee/models/student/job_applied_model.dart';
import 'package:jazzee/models/student/student_model.dart';
import 'package:jazzee/screens/applied_job_screen/widgets/applied_job_detailed_screen.dart';
import '../../../../components/basic_text.dart';
import '../../../../core/theme/base_color.dart';
import '../job_detailed_screen/job_detailed_screen.dart';
import '../saved_screen/widgets/saved_job_cards.dart';

class appliedJobScreen extends StatefulWidget {
  const appliedJobScreen({Key? key, required this.student}) : super(key: key);
  final Student student;
  @override
  State<appliedJobScreen> createState() => _appliedJobScreenState();
}

class _appliedJobScreenState extends State<appliedJobScreen> {
  late Future<List<JobApplied>> futureSavedJobsResponse;
  @override
  void initState() {
    futureSavedJobsResponse =
        GetJobPostings().GetAppliedJobs(widget.student.studentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'My Application',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            navigatorKey.currentState!.pop();
          },
        ),
        centerTitle: true,
        actions: [],
      ),
      body: FutureBuilder(
        future: futureSavedJobsResponse,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
          } else {
            final List<JobApplied> jobListings = snapshot.data;
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              itemCount: jobListings.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      navigatorKey.currentState!.push(MaterialPageRoute(
                          builder: (context) => appliedJobDetailsScreen(
                              student: widget.student,
                              job: jobListings[index])));
                    },
                    child: appliedJobCard(jobapplied: jobListings[index]));
              },
            );
          }
        },
      ),
    );
  }
}
