// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:jazzee/constants.dart/constants.dart';
import 'package:jazzee/core/theme/base_color.dart';
import 'package:jazzee/models/college/college_model.dart';
import 'package:jazzee/models/student/student_model.dart';
import 'package:jazzee/provider/user_provider.dart';
import 'package:jazzee/screens/chat_screen/recruiter/recruiter_chat_screen.dart';
import 'package:jazzee/screens/create_job_posting_screen/create_job_posting_screen.dart';
import 'package:jazzee/screens/post_screen/post_screen.dart';
import 'package:jazzee/screens/profile_screen/collage/collage_profile_screen.dart';
import 'package:jazzee/screens/profile_screen/recuiter/recruiter_profile_screen.dart';
import 'package:provider/provider.dart';
import 'models/recruiter/recruiter_model.dart';
import 'screens/chat_screen/chat_screen.dart';
import 'screens/home_screen.dart/homescreen.dart';
import 'screens/profile_screen/students/profile_screen.dart';
import 'screens/saved_screen/saved_screen.dart';

class navBar extends StatefulWidget {
  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      _pageController.dispose();
      super.dispose();
    }

    void _onItemTapped(int index) async {
      setState(() {
        _selectedIndex = index;
        _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });
    }

    return Scaffold(body: Consumer<UserProvider>(
      builder: (context, ref, child) {
        if (ref.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (ref.error != null) {
          return Center(
              child: Column(
            children: [
              Text('Error: ${ref.error}'),
              ElevatedButton(
                onPressed: () async {
                  await supabase.auth.signOut();
                },
                child: Text('logout'),
              ),
            ],
          ));
        }
        if (ref.user == null) {
          return Center(child: Text('Users not found'));
        } else {
          if (ref.user['role'] == 'students') {
            final Student user = ref.user['user'];
            return Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    children: [
                      Container(child: Center(child: homeScreen(user: user))),
                      Container(
                          child: Center(
                              child: postScreen(
                        name: user.name,
                        college: user.collageName,
                      ))),
                      Container(child: Center(child: ChatScreen())),
                      Container(
                          child:
                              Center(child: studentProfileScreen(user: user))),
                    ],
                  ),
                ),
              ],
            );
          } else if (ref.user['role'] == 'collage') {
            final Collage user = ref.user['user'];
            return Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    children: [
                      Container(
                          child: Center(
                              child: postScreen(name: user.collageName))),
                      // Container(
                      //     child: Center(
                      //         child: postScreen(name: user.collageName))),
                      Container(child: Center(child: ChatScreen())),
                      Container(
                          child: Center(
                              child: collageProfileScreen(collage: user))),
                    ],
                  ),
                ),
              ],
            );
          } else if (ref.user['role'] == 'recruiter') {
            final Recruiter user = ref.user['user'];
            return PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                Container(
                    child: Center(child: postScreen(name: user.companyName))),
                Container(child: Center(child: createJobPostingScreen())),
                Container(child: Center(child: companyChatScreen())),
                Container(
                    child:
                        Center(child: companyProfileScreen(recruiter: user))),
              ],
            );
          }
          final Student user = ref.user['user'];
          return Column(
            children: [
              Text('User: ${user.name}'),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  children: [
                    Container(child: Center(child: homeScreen())),
                    Container(
                        child: Center(child: savedJobScreen(student: user))),
                    Container(child: Center(child: ChatScreen())),
                    Container(
                        child: Center(child: studentProfileScreen(user: user))),
                  ],
                ),
              ),
            ],
          );
        }
      },
    ), bottomNavigationBar: Consumer<UserProvider>(
      builder: (context, ref, child) {
        if (ref.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (ref.error != null) {
          return Center(
              child: Column(
            children: [
              Text('Error: ${ref.error}'),
              ElevatedButton(
                onPressed: () async {
                  await supabase.auth.signOut();
                },
                child: Text('logout'),
              ),
            ],
          ));
        }
        if (ref.user == null) {
          return Center(child: Text('Users not found'));
        } else {
          if (ref.user['role'] == 'recruiter') {
            final Recruiter user = ref.user['user'];
            return Container(
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  selectedItemColor: AppColors.primarycolor2,
                  unselectedItemColor: Colors.white,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.add),
                      label: 'Add',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.send),
                      label: 'Messages',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            );
          } else if (ref.user['role'] == 'collage') {
            final Collage user = ref.user['user'];
            return Container(
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  selectedItemColor: AppColors.primarycolor2,
                  unselectedItemColor: Colors.white,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.send),
                      label: 'Messages',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            );
          }

          return Container(
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedItemColor: AppColors.primarycolor2,
                unselectedItemColor: Colors.white,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.feed),
                    label: 'Posts',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.send),
                    label: 'Messages',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          );
        }
      },
    ));
  }
}
