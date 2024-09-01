// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:jazzee/backend/auth/login.dart';
import 'package:jazzee/components/text_field.dart';
import 'package:jazzee/constants.dart/constants.dart';
import 'package:jazzee/core/theme/base_color.dart';
import 'package:jazzee/core/theme/base_font';
import 'package:jazzee/core/utils/shared_preference.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/navbar.dart';
import '../../components/button.dart';
import '../../notification/send_notification.dart';
import '../register_screen/register_screen.dart';

class loginScreen extends StatefulWidget {
  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String _roleType = 'students';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Log in',
                    style: AppTextStyles.jumboBold,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Please, log in to your account.\nIt takes less than one minute.',
                style: AppTextStyles.mediumRegular.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 40),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 1),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: DropdownButtonFormField<String>(
                  value: _roleType.isNotEmpty
                      ? _roleType
                      : null, // Initialize or use null
                  isExpanded: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _roleType = newValue!;
                      role_type = newValue;
                    });
                  },
                  items: <String>['students', 'recruiter', 'collage']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: AppColors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              text_box(
                value: emailController,
                title: 'Email',
                hint: 'Email',
              ),
              const SizedBox(height: 20),
              text_box(
                value: passwordController,
                title: 'Password',
                hint: 'Password',
                obsureText: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text('Forgot password?',
                      style: AppTextStyles.smallRegular
                          .copyWith(color: Colors.grey)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Button(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await Login().signIn(
                        emailController.text,
                        passwordController.text,
                      );
                      final session = supabase.auth.currentSession;
                      if (session != null) {
                        await SharedPreferencesService.setString(
                            'role', _roleType);
                        if (_roleType == 'students') {
                          await supabase
                              .from('students')
                              .update({
                                'token':
                                    SharedPreferencesService.getString('token'),
                              })
                              .eq('student_id', supabase.auth.currentUser!.id)
                              .then((value) async {
                                setState(() {
                                  isLoading = false;
                                });
                                await sendPushMessage(
                                    SharedPreferencesService.getString(
                                        'token')!,
                                    'Logged In Successfully',
                                    'Welcome ${supabase.auth.currentUser!.email}');
                              });
                        } else if (_roleType == 'recruiter') {
                          setState(() {
                            isLoading = false;
                          });
                          await supabase
                              .from('recruiter')
                              .update({
                                'token':
                                    SharedPreferencesService.getString('token'),
                              })
                              .eq('company_id', supabase.auth.currentUser!.id)
                              .then((value) async {
                                await sendPushMessage(
                                    SharedPreferencesService.getString(
                                        'token')!,
                                    'Logged In Successfully',
                                    'Welcome ${supabase.auth.currentUser!.email}');
                              });
                        } else {
                          await supabase
                              .from('collage')
                              .update({
                                'token':
                                    SharedPreferencesService.getString('token'),
                              })
                              .eq('collage_id', supabase.auth.currentUser!.id)
                              .then((value) async {
                                setState(() {
                                  isLoading = false;
                                });
                                await sendPushMessage(
                                    SharedPreferencesService.getString(
                                        'token')!,
                                    'Logged In Successfully',
                                    'Welcome ${supabase.auth.currentUser!.email}');
                              });
                        }
                        navigatorKey.currentState!.push(
                          MaterialPageRoute(
                            builder: (context) => navBar(),
                          ),
                        );
                      }
                    },
                    color: AppColors.black,
                    text: isLoading ? 'Loading...' : 'Log in',
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.7, 50)),
              ),
              const SizedBox(height: 20),
              // Row(
              //   children: [
              //     Expanded(child: Divider(color: Colors.grey)),
              //     Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //       child: Text(
              //         'or',
              //         style: TextStyle(color: Colors.grey),
              //       ),
              //     ),
              //     Expanded(child: Divider(color: Colors.grey)),
              //   ],
              // ),
              // const SizedBox(height: 20),
              // Container(
              //   height: 40,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       IconButton(
              //         onPressed: () {},
              //         icon: Image.asset('assets/image/google_logo.png'),
              //         iconSize: 40,
              //       ),
              //     ],
              //   ),
              // ),
              Spacer(),
              Center(
                child: TextButton(
                  onPressed: () {
                    navigatorKey.currentState!.push(
                      MaterialPageRoute(
                        builder: (context) => registerScreen(),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: 'Sign up',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
