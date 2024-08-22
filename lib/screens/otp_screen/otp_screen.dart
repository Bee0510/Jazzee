// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sobha_mart/api/login.dart';
// import 'package:sobha_mart/api/verify.dart';
// import 'package:sobha_mart/core/theme/base_color.dart';
// import 'package:sobha_mart/models/login_details/login_detail.dart';
// import 'package:sobha_mart/models/login_details/user_detail.dart';
// import 'package:sobha_mart/navbar.dart';
// import 'package:sobha_mart/screens/profile_screen/profile_screen.dart';
// import '../../core/utils/shared_preference.dart';

// class otp_screen extends StatefulWidget {
//   const otp_screen({super.key, required this.loginDetail});
//   final login_detail loginDetail;

//   @override
//   State<otp_screen> createState() => _otp_screenState();
// }

// class _otp_screenState extends State<otp_screen> {
//   bool isTapped = false;
//   final TextEditingController _controller = TextEditingController();
//   late Future<user_details> futureUserDetails;
//   String otp = '';
//   late Timer _timer;
//   int _start = 40;
//   bool _isButtonDisabled = false;

//   @override
//   void initState() {
//     super.initState();
//     futureUserDetails = verify_api().verify_user(
//         phone: widget.loginDetail.messages.status.contactOtp.toString());
//   }

//   void startTimer() {
//     setState(() {
//       _isButtonDisabled = true;
//     });
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_start == 0) {
//         setState(() {
//           _isButtonDisabled = false;
//           _start = 40;
//           timer.cancel();
//         });
//       } else {
//         setState(() {
//           _start--;
//         });
//       }
//     });
//   }

//   void validate_otp(user_details userdata) async {
//     if (otp == '') {
//       if (widget.loginDetail.messages.status.loginOtp.toString() ==
//           _controller.text) {
//         final result = await verify_api().verify_user(
//             phone: widget.loginDetail.messages.status.contactOtp.toString());
//         SharedPreferencesService.setString("user_id",
//             widget.loginDetail.messages.status.contactOtp.toString());
//         result.messages.status.status == '1' &&
//                 result.messages.status.fullname != null
//             ? Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => navbar(
//                       userDetail: userdata,
//                     )))
//             : Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => profile_screen(user_detail: userdata)));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Invalid OTP'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } else if (otp != '') {
//       if (otp == _controller.text) {
//         verify_api().verify_user(
//             phone: widget.loginDetail.messages.status.contactOtp.toString());
//         SharedPreferencesService.setString("user_id",
//             widget.loginDetail.messages.status.contactOtp.toString());

//         Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => navbar(
//                   userDetail: userdata,
//                 )));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Invalid OTP'),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userdata = Provider.of<user_details>(context);
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: FutureBuilder(
//             future: futureUserDetails,
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else if (!snapshot.hasData) {
//                 return const Center(child: Text('No Category available'));
//               } else {
//                 user_details user_data = snapshot.data!;
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.3),
//                     const Text(
//                       'Shobhamart',
//                       style: TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                     Text(
//                       'Enter the OTP sent to ${widget.loginDetail.messages.status.contactOtp}',
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                     TextField(
//                       controller: _controller,
//                       keyboardType: TextInputType.phone,
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.opacity_sharp),
//                         labelText: 'Verification code',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         InkWell(
//                           onTap: _isButtonDisabled
//                               ? null
//                               : () async {
//                                   startTimer();
//                                   final result = await login_api().login_user(
//                                       phone: widget.loginDetail.messages.status
//                                           .contactOtp);
//                                   setState(() {
//                                     otp = result.messages.status.loginOtp
//                                         .toString();
//                                   });
//                                 },
//                           child: Text(
//                             _isButtonDisabled
//                                 ? 'Resend Code ($_start s)'
//                                 : 'Resend Code',
//                             style: TextStyle(
//                               color: _isButtonDisabled
//                                   ? Colors.grey
//                                   : AppColors.primarycolor2,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 40),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primarycolor2,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: () {
//                         validate_otp(user_data);
//                       },
//                       child: Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         alignment: Alignment.center,
//                         child: const Text(
//                           'Verify Code',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Spacer(),
//                     const SizedBox(height: 20),
//                   ],
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
