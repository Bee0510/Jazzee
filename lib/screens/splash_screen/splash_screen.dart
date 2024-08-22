// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../core/theme/base_color.dart';
// import '../wrapper.dart';

// class splash_screen extends StatefulWidget {
//   const splash_screen({super.key});
//   @override
//   _splash_screenState createState() => _splash_screenState();
// }

// class _splash_screenState extends State<splash_screen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 3), () {
//       _checkFirstTime().then((bool isFirstTime) {
//         if (isFirstTime) {
//           _markFirstTime();
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => wrapper()),
//           );
//         } else {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => wrapper()),
//           );
//         }
//       });
//     });
//   }

//   Future<bool> _checkFirstTime() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('isFirstTime') ?? true;
//   }

//   Future<void> _markFirstTime() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isFirstTime', false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primarycolor2,
//       body: Center(
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.3,
//           width: MediaQuery.of(context).size.height * 0.3,
//           padding: EdgeInsets.all(8.0),
//           decoration: BoxDecoration(
//               color: AppColors.primarycolor2, shape: BoxShape.circle),
//           child: Image.asset(
//             'assets/sobha logo.png',
//             fit: BoxFit.contain,
//           ),
//         ),
//       ),
//     );
//   }
// }
