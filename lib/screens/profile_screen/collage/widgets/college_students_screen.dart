// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jazzee/constants.dart/constants.dart';
import 'package:jazzee/core/theme/base_color.dart';
import 'package:jazzee/screens/profile_screen/students/profile_screen.dart';

import '../../../../backend/getdata/get_personal_info.dart';
import '../../../../components/basic_text.dart';
import '../../../../models/student/student_model.dart';

class studentSearchPage extends StatefulWidget {
  const studentSearchPage({Key? key, required this.students}) : super(key: key);
  final List<Student> students;
  @override
  _studentSearchPageState createState() => _studentSearchPageState();
}

class _studentSearchPageState extends State<studentSearchPage> {
  List<Student> filteredStudents = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredStudents = widget.students;
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredStudents = widget.students.where((student) {
        return student.name.toLowerCase().contains(query.toLowerCase()) ||
            student.roll_no.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.black,
            floating: true,
            pinned: false,
            snap: false,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            expandedHeight: kBottomNavigationBarHeight,
            flexibleSpace: FlexibleSpaceBar(
              title: basic_text(
                  title: 'College Profile',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchBarDelegate(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.only(top: 4),
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.primarycolor2, width: 1),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: TextField(
                    onChanged: updateSearchQuery,
                    decoration: InputDecoration(
                      hintText: 'Search by name or roll number',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index >= filteredStudents.length) return null;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => collageStudentProfileScreen(
                            student: filteredStudents[index]),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 4,
                    child: Container(
                      color: AppColors.primarycolor1.withOpacity(0.1),
                      child: ListTile(
                        title: Text(
                          filteredStudents[index].name,
                          style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                        subtitle: Text(
                            'Roll Number: ${filteredStudents[index].roll_no}'),
                      ),
                    ),
                  ),
                );
              },
              childCount: filteredStudents.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SearchBarDelegate({required this.child});

  @override
  double get minExtent => 60.0;

  @override
  double get maxExtent => 60.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class collageStudentProfileScreen extends StatefulWidget {
  const collageStudentProfileScreen({Key? key, required this.student})
      : super(key: key);
  final Student student;
  @override
  State<collageStudentProfileScreen> createState() =>
      _collageStudentProfileScreenState();
}

class _collageStudentProfileScreenState
    extends State<collageStudentProfileScreen> {
  late Future<Student> futureStudentResponse;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'College Students',
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
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        actions: [],
      ),
      body: FutureBuilder(
        future: GetPersonalInfo().GetUserStudent(widget.student.studentId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
          } else {
            Student student = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/image/google_logo.png'),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      student.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${student.studentId}",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "${student.collageName}",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.mail),
                        SizedBox(width: 8),
                        Text(student.email),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.phone),
                        SizedBox(width: 8),
                        Text(student.phoneNo),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.web),
                        SizedBox(width: 8),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            student.verified ? 'Verified' : 'Not Verified',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 8),
                        Text(student.placedOnCampus.isEmpty
                            ? student.placedOnCampus
                            : 'Unplaced Till Date'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
