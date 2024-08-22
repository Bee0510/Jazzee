// // ignore_for_file: prefer_const_constructors, deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:sobha_mart/components/search_bar.dart';
// import 'package:sobha_mart/components/shopping_cart.dart';
// import 'package:sobha_mart/core/theme/base_color.dart';
// import 'package:sobha_mart/models/login_details/user_detail.dart';
// import 'package:sobha_mart/screens/all_brand_screen/all_brand_screen.dart';
// import 'package:sobha_mart/screens/explore_screen/explore_screen.dart';
// import 'package:sobha_mart/screens/home_screen.dart/home_screen.dart';

// import 'components/basic_text.dart';
// import 'components/drawer.dart';

// class navbar extends StatefulWidget {
//   const navbar({super.key, this.userDetail});
//   final user_details? userDetail;

//   @override
//   State<navbar> createState() => _navbarState();
// }

// class _navbarState extends State<navbar> {
//   int _selectedIndex = 0;
//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       _pageController.animateToPage(
//         index,
//         duration: Duration(milliseconds: 300),
//         curve: Curves.ease,
//       );
//     });
//   }

//   Future<bool> _showExitConfirmationDialog(BuildContext context) async {
//     return await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('Exit App'),
//             content: Text('Do you want to exit the app?'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(false),
//                 child: Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(true),
//                 child: Text('Exit'),
//               ),
//             ],
//           ),
//         ) ??
//         false; // If the dialog is dismissed without any action
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         bool shouldExit = await _showExitConfirmationDialog(context);
//         return shouldExit;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           toolbarHeight: kToolbarHeight,
//           leading: Builder(
//             builder: (context) {
//               return IconButton(
//                 icon: const Icon(Icons.menu, size: 30, color: Colors.white),
//                 onPressed: () {
//                   Scaffold.of(context).openDrawer();
//                 },
//               );
//             },
//           ),
//           // title: basic_text(
//           //   title: 'Shobhamart',
//           //   style: TextStyle(
//           //       color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//           // ),
//           title: Image.asset(
//             'assets/sobha logo.png',
//             height: 40,
//           ),
//           actions: [
//             // IconButton(
//             //     onPressed: () {},
//             //     icon: Icon(
//             //       Icons.notifications_none_outlined,
//             //       size: 28,
//             //       color: Colors.white,
//             //     )),
//             shopping_cart(
//               user: widget.userDetail!,
//             ),
//           ],
//           backgroundColor: AppColors.primarycolor2,
//         ),
//         drawer: drawer(
//           userDetail: widget.userDetail!,
//         ),
//         body: Column(
//           children: [
//             search_bar(
//               search: false,
//               userDetails: widget.userDetail!,
//             ),
//             Expanded(
//               child: PageView(
//                 controller: _pageController,
//                 onPageChanged: (index) {
//                   setState(() {
//                     _selectedIndex = index;
//                   });
//                 },
//                 children: [
//                   Container(
//                       child: Center(
//                           child: home_screen(
//                     userDetail: widget.userDetail,
//                   ))),
//                   Container(
//                       child: Center(
//                           child: explore_screen(
//                     userDetail: widget.userDetail!,
//                   ))),
//                   Container(
//                       child: Center(
//                           child: all_brand_screen(
//                     userDetail: widget.userDetail,
//                   ))),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           iconSize: 28,
//           selectedLabelStyle:
//               TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//           unselectedLabelStyle:
//               TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
//           selectedItemColor: AppColors.primarycolor2,
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.explore),
//               label: 'Explore',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.all_inbox),
//               label: 'All Brand',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           onTap: _onItemTapped,
//         ),
//       ),
//     );
//   }
// }
