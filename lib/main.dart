import 'dart:async';

import 'package:flutter/material.dart';
import 'package:githelp/constant.dart';
import 'package:githelp/screen/home/home.dart';
import 'package:githelp/screen/Welcome/welcome_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Git Help',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          textTheme: TextTheme(
            body1: TextStyle(color: kBodyTextColor),
          )),
      home: WelcomeScreen(),
    );
  }
}

