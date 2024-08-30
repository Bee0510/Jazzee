import 'package:flutter/material.dart';
import 'package:jazzee/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../constants.dart/constants.dart';

class Login {
  Future<void> signIn(String Email, String Password) async {
    try {
      await supabase.auth.signInWithPassword(password: Password, email: Email);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
        content: Text(e.message),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      print(e.toString());
    }
  }
}
