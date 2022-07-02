import 'package:ecommerce_app/const.dart';
import 'package:ecommerce_app/views/screens/auth/login_screen.dart';
import 'package:ecommerce_app/views/screens/bottom_navbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeData.dark().copyWith(
      //   scaffoldBackgroundColor: backgroundColor,
      // ),
      home: BottomNavBar(),
    );
  }
}
