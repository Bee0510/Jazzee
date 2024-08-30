// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:jazzee/backend/getdata/get_job_filters.dart';
import 'package:jazzee/backend/getdata/get_job_postings.dart';
import 'package:jazzee/backend/getdata/get_personal_info.dart';
import 'package:jazzee/constants.dart/constants.dart';
import 'package:jazzee/core/theme/base_color.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/models/student/job_applied_model.dart';
import 'package:jazzee/models/student/job_filter_model.dart';
import 'package:jazzee/models/student/skills_model.dart';
import 'package:jazzee/screens/filter_screen/filter_screen.dart';
import 'package:provider/provider.dart';
import '../../backend/auth/get_token.dart';
import '../../models/recruiter/jobs_posting_model.dart';
import '../../models/student/job_saved_model.dart';
import '../../models/student/student_model.dart';
import 'widgets/job_card.dart';

class homeScreen extends StatefulWidget {
  homeScreen({super.key, this.user});
  final Student? user;

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  late Future<List<JobPosting>> jobPostings;
  late Future<List<JobPosting>> filterJobPostings;
  late Future<List<JobPosting>> collageFilterJobPostings;
  late Future<List<JobPosting>> collegeJobPostings;
  final TextEditingController searchController = TextEditingController();
  late Future<Student> student;
  late Future<List<Skill>> skills;
  late Future<List<JobApplied>> jobApply;
  late Future<List<JobSaved>> futureSavedResonse;

  @override
  void initState() {
    // jobPostings = GetJobPostings().GetAllJobs();
    collageFilterJobPostings =
        GetJobPostings().GetCollegeJobs(widget.user!.collegeId!);
    filterJobPostings = GetJobPostings().GetAllJobs();
    student = GetPersonalInfo().GetUserStudent(widget.user!.studentId);
    skills = GetPersonalInfo().GetUserSkills();
    jobApply = GetJobPostings().GetAppliedJobs(widget.user!.studentId);
    futureSavedResonse = GetJobPostings().GetSavedJobs(widget.user!.studentId);
    super.initState();
  }

  Future<void> _refresh(JobFilters filter) async {
    setState(() {
      student = GetPersonalInfo().GetUserStudent(widget.user!.studentId);
      skills = GetPersonalInfo().GetUserSkills();
      filterJobPostings = FilterJobs().fetchFilteredJobs(
        filter,
        searchController.text,
      );
      collageFilterJobPostings = FilterJobs().fetchFilteredCollageJobs(
        filter,
        searchController.text,
        widget.user!.collegeId!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _refresh(JobFilters()),
        child: FutureBuilder(
          future: Future.wait([
            filterJobPostings,
            student,
            skills,
            jobApply,
            futureSavedResonse
          ]),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No data found'));
            } else {
              final List<JobPosting> jobPostings = snapshot.data[0];
              final Student user = snapshot.data[1];
              final List<Skill> skills = snapshot.data[2];
              final List<String> userSkills =
                  skills.map((e) => e.skillName).toList();
              final List<JobApplied> jobApplied = snapshot.data[3];
              final List<JobPosting> unappliedJobs = jobPostings.where((job) {
                return !jobApplied
                    .any((appliedJob) => appliedJob.jobId == job.jobId);
              }).toList();
              final List<JobSaved> jobSaved = snapshot.data[4];
              List<String> jobid = jobSaved.map((e) => e.jobId).toList();
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                      pinned: true,
                      automaticallyImplyLeading: false,
                      backgroundColor: AppColors.black,
                      elevation: 4,
                      expandedHeight: MediaQuery.of(context).size.height * 0.18,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                          padding: const EdgeInsets.only(
                              top: 40.0, left: 16.0, right: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // CircleAvatar(
                                  //   radius: 20,
                                  //   backgroundImage: AssetImage(
                                  //       'assets/image/google_logo.png'),
                                  // ),
                                  // SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hi ${user.name}!',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      Text(
                                        "Let's find your dream job!",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(10.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 100,
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Search',
                                          border: InputBorder.none,
                                        ),
                                        controller: searchController,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        _refresh(JobFilters());
                                      },
                                      child: Container(
                                        width: 40,
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: AppColors.black,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Icon(Icons.search,
                                            color: Colors.grey),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  final JobFilters result = await navigatorKey
                                      .currentState!
                                      .push(MaterialPageRoute(
                                          builder: (context) =>
                                              filtersScreen()));
                                  if (result != null) {
                                    print(result.jobTypes);
                                    _refresh(result);
                                  }
                                },
                                child: Container(
                                  width: 40,
                                  margin: EdgeInsets.only(left: 16.0),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.filter_alt_outlined,
                                      color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'On Campus Jobs',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: 10),
                        FutureBuilder(
                          future: collageFilterJobPostings,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text(snapshot.error.toString()));
                            } else if (!snapshot.hasData) {
                              return Center(child: Text('No data found'));
                            } else {
                              final List<JobPosting> recommendedJobs =
                                  snapshot.data;
                              return jobPostings.isEmpty
                                  ? Container(
                                      child: Center(
                                        child: Text('No Result Found'),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.27,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          physics: BouncingScrollPhysics(),
                                          itemCount: recommendedJobs.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16.0),
                                              child: JobCard(
                                                job: recommendedJobs[index],
                                                isRecommended: true,
                                                skills: userSkills,
                                                student: user,
                                                savedJob: jobid,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                            }
                          },
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        //   child: Container(
                        //     height: MediaQuery.of(context).size.height * 0.3,
                        //     child: ListView.builder(
                        //       shrinkWrap: true,
                        //       scrollDirection: Axis.horizontal,
                        //       physics: BouncingScrollPhysics(),
                        //       itemCount: recommendedJobs.length,
                        //       itemBuilder: (context, index) {
                        //         return Padding(
                        //           padding: const EdgeInsets.only(right: 16.0),
                        //           child: JobCard(
                        //               job: recommendedJobs[index],
                        //               isRecommended: true),
                        //         );
                        //       },
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Recent Jobs',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        jobPostings.isEmpty
                            ? Container(
                                child: Center(
                                  child: Text('No Result Found'),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: unappliedJobs.length,
                                  itemBuilder: (context, index) {
                                    return JobCard(
                                      job: unappliedJobs[index],
                                      isRecommended: false,
                                      skills: userSkills,
                                      student: user,
                                      savedJob: jobid,
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
