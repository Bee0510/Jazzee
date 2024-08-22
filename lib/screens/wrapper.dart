// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import '../models/login_details/user_detail.dart';
// import 'login_screen.dart/login_screen.dart';

// class wrapper extends StatefulWidget {
//   const wrapper({super.key});

//   @override
//   State<wrapper> createState() => _wrapperState();
// }

// class _wrapperState extends State<wrapper> {
//   Future<user_details?> fetchUserDetails() async {
//     // final number = SharedPreferencesService.getString("user_id");
//     // if (number != null) {
//     //   final userDetails = await userDetailsStream(number).first;
//     //   return userDetails;
//     // }
//     // return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<user_details?>(
//       future: fetchUserDetails(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         } else if (snapshot.hasData) {
//           final user = snapshot.data!;
//           if (user.messages.status.isLoggedIn) {
//             if (user.messages.status.status == '0' &&
//                 user.messages.status.fullname == '') {
//               return profile_screen(
//                 user_detail: user,
//               );
//             } else {
//               return navbar(
//                 userDetail: user,
//               );
//             }
//           } else {
//             return login_screen();
//           }
//         } else {
//           return login_screen();
//         }
//       },
//     );
//   }
// }
