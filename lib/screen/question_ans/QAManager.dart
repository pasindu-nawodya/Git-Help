import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:githelp/component/header/header.dart';
import 'package:githelp/screen/home/home.dart';

import './QuestionAnswer.dart';

class QuestionAnswerManager extends StatefulWidget {
  const QuestionAnswerManager({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _QuestionAnswerState();
  }
}

class _QuestionAnswerState extends State<QuestionAnswerManager> {
  final controller = ScrollController();
  final firestoreInstance = FirebaseFirestore.instance;

  List<String> _questions = ['question tester'];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: <Widget>[
              MyHeader(
                image: "",
                textTop: "",
                textBottom: "Ask your questions here...",
                offset: 10.0,
                heights: 220.0,
                topVal: 0.0,
                leftVal: 15.0,
              ),

              // home and Add question buttons
              Container(
                child: Row(
                  children: [
                    SizedBox(width: 100.0),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => (Home())),
                        );
                      },
                      backgroundColor: Colors.indigo,
                      child: const Icon(Icons.home),
                    ),
                    SizedBox(width: 100.0),
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _questions.add('Advanced question tester');
                        });
                      },
                      backgroundColor: Colors.indigo,
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: <Widget>[
                        QuestionAnswer(_questions)
                      ],
                    )
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
