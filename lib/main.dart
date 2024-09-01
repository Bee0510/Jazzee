// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:jazzee/screens/chat_screen/chat_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:jazzee/backend/auth/get_token.dart';
import 'package:jazzee/constants.dart/constants.dart';
import 'package:jazzee/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/utils/shared_preference.dart';
import 'notification/notification.dart';
import 'provider/user_provider.dart';

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  String payloadData = jsonEncode(message.data);

  if (message.notification != null) {
    PushNotifications.showSimpleNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
        payload: payloadData);
  }
}

// to handle notification on foreground on web platform
void showNotification({required String title, required String body}) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"))
      ],
    ),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final token = await getToken();
  print('tokken :$token');

  await Supabase.initialize(
    url: 'https://bgjkqfvmjonzzbouzqxc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJnamtxZnZtam9uenpib3V6cXhjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjQ0NDEwMTMsImV4cCI6MjA0MDAxNzAxM30.zjqYfLRIb0N1QI9Ms2wdrPQftdjUsTiCloQj2yatHrs',
  );
  if (!kIsWeb) {
    await PushNotifications.localNotiInit();
  }

  // Listen to background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped");
      print(message.data['order_id']);
      final userId = SharedPreferencesService.getString('userId');
      print('message is ${message.data['message']}');
      navigatorKey.currentState!
          .pushNamed("/notification", arguments: message.data['message']);
    }
  });
// to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");

    if (message.notification != null) {
      print("Notification Title: ${message.notification!.title}");
      print("Notification Body: ${message.notification!.body}");

      if (kIsWeb) {
        showNotification(
            title: message.notification!.title!,
            body: message.notification!.body!);
      } else {
        print("Showing notification on device");
        PushNotifications.showSimpleNotification(
            title: message.notification!.title!,
            body: message.notification!.body!,
            payload: payloadData);
      }
    }
  });

  // for handling in terminated state
  final RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    print("Launched from terminated state");
    navigatorKey.currentState
        ?.pushNamed("/notification", arguments: initialMessage.data['message']);
  }
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _token = await _firebaseMessaging.getToken();
  if (_token != null) {
    SharedPreferencesService.setString('token', _token);
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => TokenProvider(),
      child: MyApp(),
    ),
  );
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserProvider()
              ..fetchUser(supabase.auth.currentUser!.id, role_type),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Montserrat'),
          navigatorKey: navigatorKey,
          routes: {
            '/home_screen': (context) => splash_screen(),
            '/notification': (context) => ChatScreen(),
          },
          initialRoute: '/home_screen',
        ));
  }
}
