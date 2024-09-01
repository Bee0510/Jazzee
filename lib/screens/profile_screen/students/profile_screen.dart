// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jazzee/core/theme/base_color.dart';
import 'package:jazzee/core/theme/base_font';
import 'package:jazzee/core/utils/shared_preference.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/models/student/student_model.dart';
import 'package:jazzee/screens/applied_job_screen/applied_job_screen.dart';
import 'package:jazzee/screens/resume_screen/resume_screen.dart';
import 'package:jazzee/screens/saved_screen/saved_screen.dart';
import '../../../../../components/basic_text.dart';
import '../../../../../constants.dart/constants.dart';
import '../../personal_info_screen/personal_info_screen.dart';
import '../../wrapper.dart';

class studentProfileScreen extends StatefulWidget {
  const studentProfileScreen({super.key, required this.user});
  final Student user;
  @override
  State<studentProfileScreen> createState() => _studentProfileScreenState();
}

class _studentProfileScreenState extends State<studentProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final int analysis =
        int.parse(SharedPreferencesService.getString('analysis') ?? '0');
    final List<Map<String, dynamic>> settings = [
      {
        'title': 'Personal Information',
        'icon': Icons.person,
        'route': personalInfoScreen(
          user: widget.user,
        )
      },
      {
        'title': 'My Application',
        'icon': Icons.article_outlined,
        'route': appliedJobScreen(
          student: widget.user,
        )
      },
      {
        'title': 'My Resume',
        'icon': Icons.language,
        'route': ResumeUploader(
          studentId: widget.user.studentId,
        )
      },
      {
        'title': 'Saved Jobs',
        'icon': Icons.work_outline,
        'route': savedJobScreen(student: widget.user)
      },
      {
        'title': 'Privacy Policy',
        'icon': Icons.privacy_tip_outlined,
        'route': personalInfoScreen(
          user: widget.user,
        )
      },
      {
        'title': 'Log Out',
        'icon': Icons.power_settings_new,
      },
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'My Profile',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(Random().nextInt(0xffffffff)),
                    child: Text(
                      widget.user.name[0],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.user.collageName!,
                        style: TextStyle(color: Colors.grey),
                      ),
                      // Row(
                      //   children: [
                      //     Icon(Icons.location_on, color: Colors.grey, size: 16),
                      //     SizedBox(width: 4),
                      //     Text(
                      //       'Aligadh',
                      //       style: TextStyle(color: Colors.grey),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Profile Completion (${((analysis / 6) * 100).toStringAsFixed(2)}%)',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.green),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                height: 13,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width * (analysis / 6),
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.primarycolor2,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Account Setting',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: settings.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: buildListTile(
                        settings[index]['title'],
                        settings[index]['icon'],
                        settings[index]['route'],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListTile(String title, IconData icon, Widget? route) {
    return InkWell(
      onTap: () async {
        if (route != null) {
          navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (context) => route,
            ),
          );
        } else {
          await supabase.auth.signOut().then((value) {
            navigatorKey.currentState!.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => wrapper()),
                (route) => false);
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: AppColors.black,
          ),
          title: Text(
            title,
            style: AppTextStyles.smallBold,
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
