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
import 'package:cloud_firestore/cloud_firestore.dart';


class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final controller = ScrollController();
  String _email, _password;
  CollectionReference post = FirebaseFirestore.instance.collection('Accounts');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> addPost() {
    // Call the user's CollectionReference to add a new user
    return post
        .add({
      'email': _email,
      'password': _password,
    })
        .then((value) => {
      print("Account Added"),
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => (LoginScreen())),
      )
    })
    // ignore: return_of_invalid_type_from_catch_error
        .catchError((error) => print(error));

  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child:Form(
        //key: _formKey,
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
              onChanged: (String val){
                setState(() {
                  _email = val;
                });
              },

            ),
            RoundedPasswordField(
                onChanged: (String val){
                  setState(() {
                    _email = val;
                  });
                },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: addPost,
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
      ),
    );
        // return Container();
  }
}



