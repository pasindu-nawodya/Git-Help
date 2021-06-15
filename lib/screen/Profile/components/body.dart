import 'package:flutter/material.dart';
import 'package:githelp/screen/Profile/components/background.dart';
import 'package:githelp/component/rounded_button.dart';
import 'package:githelp/component/rounded_input_field.dart';
import 'package:githelp/component/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "My PROFILE",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/profile.svg",
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
              text: "UPDATE",
              press: () {},
            ),
            RoundedButton(
              text: "DELETE",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),

          ],
        ),
      ),
    );
  }
}
