import 'package:flutter/material.dart';
import 'package:githelp/screen/Profile/components/body.dart';

class ProfileScreen extends StatelessWidget {
  String get aid => null;
  String get email => null;
  String get password => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(email,password,aid),
    );
  }
}
