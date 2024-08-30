// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:jazzee/backend/getdata/get_job_postings.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/models/student/job_applied_model.dart';
import 'package:jazzee/models/student/job_saved_model.dart';
import 'package:jazzee/models/student/student_model.dart';
import 'package:jazzee/screens/applied_job_screen/widgets/applied_job_detailed_screen.dart';
import 'package:jazzee/screens/job_detailed_screen/job_detailed_screen.dart';
import 'package:jazzee/screens/saved_screen/widgets/saved_job_detailed_screen.dart';
import '../../../../components/basic_text.dart';
import '../../../../core/theme/base_color.dart';
import '../saved_screen/widgets/saved_job_cards.dart';

class savedJobScreen extends StatefulWidget {
  const savedJobScreen({Key? key, required this.student}) : super(key: key);
  final Student student;
  @override
  State<savedJobScreen> createState() => _savedJobScreenState();
}

class _savedJobScreenState extends State<savedJobScreen> {
  late Future<List<JobSaved>> futureSavedJobsResponse;
  @override
  void initState() {
    _refresh();
    super.initState();
  }

  Future<void> _refresh() async {
    setState(() {
      futureSavedJobsResponse =
          GetJobPostings().GetSavedJobs(widget.student.studentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'My Saved Jobs',
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
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder(
          future: futureSavedJobsResponse,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No data found'));
            } else {
              final List<JobSaved> jobListings = snapshot.data;
              return jobListings.isEmpty
                  ? Center(
                      child: Text(
                        'No Saved Jobs',
                        style: TextStyle(color: AppColors.primarycolor2),
                      ),
                    )
                  : ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      itemCount: jobListings.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () async {
                              final result = await navigatorKey.currentState!
                                  .push(MaterialPageRoute(
                                      builder: (context) =>
                                          savedJobDetailsScreen(
                                              student: widget.student,
                                              job: jobListings[index])));
                              if (result != null) {
                                _refresh();
                              }
                            },
                            child:
                                savedJobCard(jobapplied: jobListings[index]));
                      },
                    );
            }
          },
        ),
      ),
    );
  }
}
