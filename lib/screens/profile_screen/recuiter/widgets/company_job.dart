// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jazzee/backend/getdata/get_job_postings.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/screens/job_detailed_screen/recruiter/recuriter_job_detailed_screen.dart';
import 'package:jazzee/screens/saved_screen/widgets/compay_saved_job.dart';
import '../../../../components/basic_text.dart';
import '../../../../core/theme/base_color.dart';
import '../../../../models/recruiter/jobs_posting_model.dart';

class companyJobScreen extends StatefulWidget {
  const companyJobScreen({Key? key, required this.userId}) : super(key: key);
  final String userId;
  @override
  State<companyJobScreen> createState() => _companyJobScreenState();
}

class _companyJobScreenState extends State<companyJobScreen> {
  late Future<List<JobPosting>> futureJobPostings;
  @override
  void initState() {
    futureJobPostings = GetJobPostings().GetJobs(widget.userId);
    super.initState();
  }

  Future<void> _refreshPage() async {
    setState(() {
      futureJobPostings = GetJobPostings().GetJobs(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'Job Postings',
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
        onRefresh: _refreshPage,
        child: FutureBuilder(
          future: Future.wait([futureJobPostings]),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No Address available'));
            } else {
              final List<JobPosting> jobListings = snapshot.data[0];
              print(jobListings);
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                itemCount: jobListings.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () async {
                        final result = await navigatorKey.currentState!.push(
                            MaterialPageRoute(
                                builder: (context) => CompanyJobDetailsScreen(
                                    job: jobListings[index])));
                        if (result == 'refresh') {
                          _refreshPage;
                        }
                      },
                      child: CompanysavedJobCard(job: jobListings[index]));
                },
              );
            }
          },
        ),
      ),
    );
  }
}
