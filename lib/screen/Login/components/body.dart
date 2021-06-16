import 'package:flutter/material.dart';
import 'package:githelp/screen/Login/components/background.dart';
import 'package:githelp/screen/Profile/profile_screen.dart';
import 'package:githelp/screen/Signup/signup_screen.dart';
import 'package:githelp/component/already_have_an_account_acheck.dart';
import 'package:githelp/component/rounded_button.dart';
import 'package:githelp/component/rounded_input_field.dart';
import 'package:githelp/component/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:githelp/screen/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}
class _BodyState extends State<Body> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Home();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


