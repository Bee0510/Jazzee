// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:jazzee/backend/auth/get_token.dart';
import 'package:jazzee/constants.dart/constants.dart';
import 'package:jazzee/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/utils/shared_preference.dart';
import 'provider/user_provider.dart';

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
  // final apiKey = "gw8rd9kv5m4e";
  // final client = StreamChatClient(
  //   apiKey,
  //   logLevel: Level.INFO,
  // );
  // await client.connectUser(
  //   user.User(id: 'super-band-9'),
  //   token,
  // );
  // final channel = client.channel(
  //   'messaging',
  //   id: 'flutterdevs',
  //   extraData: {
  //     'name': 'Flutter devs',
  //   },
  // );
  // final message = Message(
  //   text:
  //       'I told them I was pesca-pescatarian. Which is one who eats solely fish who eat other fish.',
  //   extraData: {
  //     'customField': '123',
  //   },
  // );
  // await channel.sendMessage(message);

  // await channel.watch();

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
          routes: {'/home_screen': (context) => splash_screen()},
          initialRoute: '/home_screen',
        ));
  }
}
