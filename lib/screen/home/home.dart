import 'package:flutter/material.dart';
import 'package:githelp/component/card/card.dart';
import 'package:githelp/component/header/header.dart';

import '../../constant.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: <Widget>[
            MyHeader(
              image: "assets/icons/teacher.svg",
              textTop: "Let's Learn Git",
              textBottom: "Step By Step",
              offset: 10.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  CardView(
                    text:
                    "Click here to learn git step by step. All the command, description and examples are there.",
                    image: "assets/images/guide.png",
                    title: "GIT Guide",
                  ),
                  CardView(
                    text:
                    "Click here if you have any doubt or problem related to GIT. Just post here or share your knowledge with others.",
                    image: "assets/images/que.png",
                    title: "Q & A Section",
                  ),
                  SizedBox(height: 50),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


