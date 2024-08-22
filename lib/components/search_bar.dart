// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:sobha_mart/components/basic_text.dart';
// import 'package:sobha_mart/models/login_details/user_detail.dart';
// import 'package:sobha_mart/screens/search_screen.dart/search_screen.dart';

// import '../core/theme/base_color.dart';

// class search_bar extends StatelessWidget {
//   const search_bar(
//       {super.key, required this.search, required this.userDetails});
//   final bool search;
//   final user_details userDetails;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => search_screen(
//                   userDetails: userDetails,
//                 )));
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//         width: MediaQuery.of(context).size.width * 1,
//         color: AppColors.primarycolor2,
//         child: Container(
//           width: MediaQuery.of(context).size.width * 0.4,
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.longestSide * 0.06,
//                 child: Icon(
//                   Icons.search_outlined,
//                   size: 30,
//                   color: AppColors.grey3,
//                 ),
//               ),
//               SizedBox(width: 10),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.6,
//                 child: search
//                     ? TextField(
//                         decoration: InputDecoration(
//                           hintText: 'Search Products',
//                           border: InputBorder.none,
//                           hintStyle: Theme.of(context)
//                               .textTheme
//                               .bodyText1!
//                               .copyWith(color: AppColors.grey3),
//                         ),
//                       )
//                     : basic_text(
//                         title: 'Search Products',
//                         style: Theme.of(context)
//                             .textTheme
//                             .bodyText1!
//                             .copyWith(color: AppColors.grey3, fontSize: 18),
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
