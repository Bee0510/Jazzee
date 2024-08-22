// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jazzee/screens/home_screen.dart/homescreen.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/utils/shared_preference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.initialize();
  await Supabase.initialize(
    url: 'https://hmndbpnziyvwdtevqbsg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhtbmRicG56aXl2d2R0ZXZxYnNnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjQzMDYxODcsImV4cCI6MjAzOTg4MjE4N30.oaCau5D7VpqLT10YJFGcg-cTyKw2Aq_OC3czrMgSdH0',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final number = SharedPreferencesService.getString("user_id");
    print('number is ${number}');
    return
        // MultiProvider(
        //   providers: [
        // StreamProvider<user_details?>(
        //   create: (context) => userDetailsStream(number.toString()),
        //   child: wrapper(),
        //   initialData: user_details(
        //     status: 0,
        //     error: false,
        //     messages: Messages(
        //       responsecode: '',
        //       status: UserStatus(
        //         userId: '',
        //         fullname: null,
        //         email: null,
        //         contact: '',
        //         status: null,
        //         lat: null,
        //         lng: null,
        //         storeImage: null,
        //         storeName: null,
        //         isLoggedIn: false,
        //       ),
        //     ),
        //   ),
        // ),
        // ],
        // child:
        MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      routes: {
        // '/login_screen': (context) => login_screen(),
        // '/otp_screen': (context) => otp_screen(),
        // '/navbar': (context) => navbar(),
        '/home_screen': (context) => homeScreen(),
        // '/profile_screen': (context) => profile_screen(),
        // '/wrapper': (context) => splash_screen()
      },
      initialRoute: '/home_screen',
    );
  }
}
