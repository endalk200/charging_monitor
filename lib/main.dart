import 'package:flutter/material.dart';
import 'package:charging_monitor/constants.dart';
import 'package:charging_monitor/screen/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Charging Monitor',
      theme: ThemeData(
        primaryColor: primary_color,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomeScreen(),
    );
  }
}
