// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_element, camel_case_types, unused_import

import 'package:flutter/material.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/navbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../constants.dart/constants.dart';
import 'login_screen.dart/login_screen.dart';

class wrapper extends StatefulWidget {
  const wrapper({super.key});

  @override
  State<wrapper> createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {
  Future<void> _authDecider() async {
    await Future.delayed(Duration.zero);

    final session = supabase.auth.currentSession;
    final user = supabase.auth.currentUser;
    print('session is $session');
    print('user is $user');
    if (session == null) {
      navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => loginScreen()),
          (route) => false);
    } else {
      navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => navBar()), (route) => false);
    }
  }

  @override
  void initState() {
    _authDecider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
