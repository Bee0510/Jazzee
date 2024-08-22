// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:sobha_mart/api/login.dart';
// import 'package:sobha_mart/components/basic_text.dart';
// import 'package:sobha_mart/core/theme/base_color.dart';
// import 'package:sobha_mart/screens/otp_screen/otp_screen.dart';

// class login_screen extends StatefulWidget {
//   const login_screen({super.key});

//   @override
//   State<login_screen> createState() => _login_screenState();
// }

// class _login_screenState extends State<login_screen> {
//   bool isTapped = false;
//   final TextEditingController _controller = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       body: Form(
//         key: _formKey,
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.3),
//                 Image.asset(
//                   'assets/sobha logo blue.png',
//                   fit: BoxFit.cover,
//                   height: MediaQuery.of(context).size.height * 0.1,
//                   width: MediaQuery.of(context).size.width * 0.6,
//                 ),
//                 SizedBox(height: 30),
//                 Text(
//                   'Welcome to Sobhamart',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 TextFormField(
//                   controller: _controller,
//                   keyboardType: TextInputType.phone,
//                   validator: (value) {
//                     if (value == null || value.isEmpty || value.length != 10) {
//                       return 'Please enter your phone number';
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.phone),
//                     labelText: 'Phone number',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primarycolor2,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       var userDetails =
//                           await login_api().login_user(phone: _controller.text);
//                       if (userDetails.messages.status.loginOtp != null) {
//                         print(userDetails.messages.status.loginOtp);
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     otp_screen(loginDetail: userDetails)));
//                       } else {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: Text('Login Failed'),
//                               content: Text(
//                                   'Failed to login. Please try again later.'),
//                               actions: <Widget>[
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Text('OK'),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       }
//                     }
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     alignment: Alignment.center,
//                     child: Text(
//                       'Login',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Spacer(),
//                 SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
