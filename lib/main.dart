import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'dashboard.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'LOGIN PAGE';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        body: UserDashboard(),
      ),
    );
  }
}




