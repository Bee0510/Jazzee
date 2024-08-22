// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';
// import 'package:sobha_mart/api/home.dart';
// import 'package:sobha_mart/api/verify.dart';
// import 'package:sobha_mart/core/utils/shared_preference.dart';
// import 'package:sobha_mart/models/api_response.dart';
// import 'package:sobha_mart/models/login_details/user_detail.dart';
// import 'package:sobha_mart/screens/home_screen.dart/widgets/banner_section.dart';
// import 'package:sobha_mart/screens/home_screen.dart/widgets/brand_section.dart';
// import 'package:sobha_mart/screens/home_screen.dart/widgets/catagory_section.dart';
// import 'package:sobha_mart/screens/home_screen.dart/widgets/offer_section.dart';

// class home_screen extends StatefulWidget {
//   const home_screen({super.key, this.userDetail});
//   final user_details? userDetail;

//   @override
//   State<home_screen> createState() => _home_screenState();
// }

// class _home_screenState extends State<home_screen> {
//   late ScrollController _controller;
//   late Future<home_response> futureHomeResponse;
//   String message = '';
//   final List<String> banners = [
//     'Banner 1',
//     'Banner 2',
//     'Banner 3',
//     'Banner 4',
//     'Banner 5',
//   ];
//   _scrollListener() {
//     if (_controller.offset >= _controller.position.maxScrollExtent &&
//         !_controller.position.outOfRange) {
//       setState(() {
//         message = "reach the bottom";
//       });
//     }
//     if (_controller.offset <= _controller.position.minScrollExtent &&
//         !_controller.position.outOfRange) {
//       setState(() {
//         message = "reach the top";
//       });
//     }
//   }

//   @override
//   void initState() {
//     _controller = ScrollController();
//     _controller.addListener(_scrollListener);
//     userDetailsStream(SharedPreferencesService.getString("user_id").toString());
//     futureHomeResponse = home_api()
//         .home_user(user_id: widget.userDetail!.messages.status.userId);
//     print(widget.userDetail!.messages.status.userId);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<user_details>(context);
//     final nunb = SharedPreferencesService.getString("user_id");
//     final homedata = Provider.of<home_response>(context);
//     return SafeArea(
//         child: SingleChildScrollView(
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
//             height: MediaQuery.of(context).size.height * 0.28,
//             child: banner_section(
//               home_responses: futureHomeResponse,
//             ),
//           ),
//           SizedBox(height: 10),
//           catagory_section(
//             home_responses: futureHomeResponse,
//             user: widget.userDetail!,
//           ),
//           SizedBox(height: 14),
//           offer_section(home_responses: futureHomeResponse),
//           brand_section(
//             home_responses: futureHomeResponse,
//             user: widget.userDetail!,
//           ),
//         ],
//       ),
//     ));
//   }
// }
