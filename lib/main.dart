import 'package:flutter/material.dart';
import 'package:internship/Screens/AdminScreens/admindashboard.dart';
import 'Screens/AdminScreens/grade.dart';
import 'Screens/AdminScreens/request.dart';
import 'Screens/UserScreens/login.dart';
import 'Screens/UserScreens/signup.dart';
import 'Screens/UserScreens/dashboard.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'LOGIN PAGE';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RequestScreen(),

    );
  }
}




