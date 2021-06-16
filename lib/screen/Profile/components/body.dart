import 'package:flutter/material.dart';
import 'package:githelp/screen/Login/login_screen.dart';
import 'package:githelp/screen/Profile/components/background.dart';
import 'package:githelp/component/rounded_button.dart';
import 'package:githelp/component/rounded_input_field.dart';
import 'package:githelp/component/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:githelp/screen/Profile/profile_screen.dart';

class Body extends StatefulWidget {

  String email;
  String password;
  String aid;
  Body(this.email,this.password,this.aid);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final controller = ScrollController();
  List<String> stepList;
  String AccountId,email,password;
  final firestoreInstance = FirebaseFirestore.instance;
  CollectionReference post = FirebaseFirestore.instance.collection('Accounts');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Future<void> updatePost() {
    // Call the user's CollectionReference to add a new user
    return post
        .add({
      'email': email,
      'password': password,
    })
        .then((value) => {
      print("Account Updated"),
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => (ProfileScreen())),
      )
    })
    // ignore: return_of_invalid_type_from_catch_error
        .catchError((error) => print(error));

  }


  deletePost() async{
    await firestoreInstance.collection("Accounts").where("email", isEqualTo : email).get().then((value){
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection("Accounts").doc(element.id).delete().then((value){
          print("Success!");
        });
      });
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => (LoginScreen())),
    );
  }
  deletePosta() async{
    await firestoreInstance.collection("Accounts").where("email", isEqualTo : email).get().then((value){
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection("Accounts").doc(element.id).delete().then((value){
          print("Success!");
        });
      });
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => (LoginScreen())),
    );
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child:Form(
          key: _formKey,
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
              hintText: "dilanjan@gmail.com",
              onChanged: (String val){
                setState(() {
                  email = val;
                });
              },
            ),
            RoundedPasswordField(

              onChanged: (String val){
                setState(() {
                   password = val;
                });
              },
            ),
            RoundedButton(
              text: "UPDATE",
              press: () {
                deletePost();
                updatePost();
              },
            ),
            RoundedButton(
              text: "DELETE",
              press: () {
                deletePosta();
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (LoginScreen())),
              );},
            ),
            RoundedButton(
              text: "SIGN OUT",
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
            SizedBox(height: size.height * 0.03),

          ],
        ),
      ),
    )
    );
  }
  }



