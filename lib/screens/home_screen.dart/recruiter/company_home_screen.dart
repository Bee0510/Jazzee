// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:jazzee/constants.dart/constants.dart';
import 'package:jazzee/core/theme/base_color.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/models/recruiter/recruiter_model.dart';
import 'package:jazzee/models/student/job_filter_model.dart';
import 'package:jazzee/screens/filter_screen/filter_screen.dart';

class companyHomeScreen extends StatefulWidget {
  companyHomeScreen({super.key, required this.user});
  final Recruiter user;

  @override
  State<companyHomeScreen> createState() => _companyHomeScreenState();
}

class _companyHomeScreenState extends State<companyHomeScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Future<void> _refresh(JobFilters filter) async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () => _refresh(JobFilters()),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: AppColors.black,
                  elevation: 4,
                  // expandedHeight: MediaQuery.of(context).size.height * 0.12,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.only(
                          top: 40.0, left: 16.0, right: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   'Hi ${widget.user!.companyName}!',
                                  //   style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontWeight: FontWeight.w500,
                                  //       fontSize: 16,
                                  //       overflow: TextOverflow.ellipsis),
                                  // ),
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
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:
                                        Icon(Icons.search, color: Colors.grey),
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
                                      builder: (context) => filtersScreen()));
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
                  [],
                ),
              ),
            ],
          )),
    );
  }
}
