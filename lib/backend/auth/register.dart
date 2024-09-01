import 'package:flutter/material.dart';
import 'package:jazzee/core/utils/shared_preference.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/notification/send_notification.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../screens/login_screen.dart/login_screen.dart';

class Register {
  final supabase = Supabase.instance.client;

  Future<void> register({
    required String email,
    required String password,
    required String roleType,
    required String name,
    required String phone_no,
    String? collage_id,
    String? collage_name,
    required String roll_no,
    required String college_code,
    required String gst,
  }) async {
    try {
      final response =
          await supabase.auth.signUp(email: email, password: password);

      final user = response.user;

      if (user != null) {
        print('User created: ${user.email}');
        await storeUserData(user.id, roleType, name, email, phone_no,
            collage_name, collage_id, roll_no, college_code, gst);
        ScaffoldMessenger.of(navigatorKey.currentContext!)
            .showSnackBar(SnackBar(
              content: Text('$roleType Registered Successfully'),
              backgroundColor: Colors.green,
            ))
            .closed
            .then((reason) {
          navigatorKey.currentState!.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => loginScreen()),
              (route) => false);
        });
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
        content: Text(e.message),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      print('Error signing up: $e');
    }
  }

  Future<void> storeUserData(
    String userId,
    String roleType,
    String name,
    String email,
    String phone_no,
    String? collage_name,
    String? collage_id,
    String roll_no,
    String collage_code,
    String gst,
  ) async {
    try {
      if (roleType == 'students') {
        await supabase.from('students').insert({
          'student_id': userId,
          'name': name,
          'email': email,
          'phone_no': phone_no,
          'collage_name': collage_name,
          'college_id': collage_id,
          'roll_no': roll_no,
          'token': SharedPreferencesService.getString('token')
        }).then((value) async {
          await sendPushMessage(SharedPreferencesService.getString('token')!,
              'Registeration Successful', 'Welcome ${name}');
        });
      } else if (roleType == 'recruiter') {
        await supabase.from('recruiter').insert({
          'company_id': userId,
          'company_name': name,
          'company_telephone': phone_no,
          'company_email': email,
          'gst': gst,
          'token': SharedPreferencesService.getString('token')
        }).then((value) async {
          await sendPushMessage(SharedPreferencesService.getString('token')!,
              'Registeration Successful', 'Welcome ${name}');
        });
      } else if (roleType == 'collage') {
        await supabase.from('collage').insert({
          'collage_id': userId,
          'collage_name': name,
          'collage_mail': email,
          'collage_no': phone_no,
          'collage_code': collage_code,
          'token': SharedPreferencesService.getString('token')
        }).then((value) async {
          await sendPushMessage(SharedPreferencesService.getString('token')!,
              'Registeration Successful', 'Welcome ${name}');
        });
      } else {
        throw Exception("Invalid role type");
      }
    } catch (e) {
      print('Error storing user data: $e');
    }
  }
}
