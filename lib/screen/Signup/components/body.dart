
import 'package:flutter/material.dart';
import 'package:githelp/screen/Login/login_screen.dart';
import 'package:githelp/screen/Signup/components/background.dart';
import 'package:githelp/screen/Signup/components/or_divider.dart';
import 'package:githelp/screen/Signup/components/social_icon.dart';
import 'package:githelp/component/already_have_an_account_acheck.dart';
import 'package:githelp/component/rounded_button.dart';
import 'package:githelp/component/rounded_input_field.dart';
import 'package:githelp/component/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:githelp/screen/home/home.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    onPressedSignUp(){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => (Home())),
      );
    }
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                //please add your implementation to below method
                // it is define in top of the class
                //pasindu
                onPressedSignUp();
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
