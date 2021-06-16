import 'package:flutter/material.dart';
import 'package:githelp/component/card/card.dart';
import 'package:githelp/component/header/header.dart';
import 'package:githelp/screen/Profile/profile_screen.dart';
import 'package:githelp/screen/guide/guide.dart';

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
    return WillPopScope(
        onWillPop: () {
      return new Future(() => false);
    },
    child:  Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: <Widget>[
            MyHeader(
              image: "assets/icons/teacher.svg",
              textTop: "Let's Learn Git",
              textBottom: "Step By Step",
              offset: 10.0,
              heights: 350.0,
              topVal: 80.0,
              leftVal: 10.0,
            ),
            Text("Select Your Path", style: kTitleTextstyle),
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
                    widget: GuideList(),
                  ),

                  CardView(
                    text:
                    "Click here if you have any doubt or problem related to GIT. Just post here or share your knowledge with others.",
                    image: "assets/images/que.png",
                    title: "Q & A Section",

                  ),
                  SizedBox(height: 10),
                  Align(
                      alignment: Alignment(0.9, 0.5),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 230.0,),
                          FloatingActionButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => (Home())),
                              );
                            },
                            backgroundColor: Colors.indigo,
                            child: const Icon(Icons.details),
                          ),
                          SizedBox(width: 10.0,),
                          FloatingActionButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => (ProfileScreen())),
                              );
                            },
                            backgroundColor: Colors.indigo,
                            child: const Icon(Icons.account_box),
                          )
                        ],
                      )
                  ),
                  SizedBox(height: 50),

                ],
              ),
            )
          ],
        ),
      ),
    ),
    );
  }
}