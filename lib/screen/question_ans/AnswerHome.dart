import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:githelp/component/header/header.dart';
import 'package:githelp/component/topic-card/topic-card.dart';

import './Answer.dart';

class AnswerManager extends StatefulWidget {

  const AnswerManager({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AnswerState();
  }
}

class _AnswerState extends State<AnswerManager> {

  final controller = ScrollController();
  final firestoreInstance = FirebaseFirestore.instance;

  Map<String,dynamic> dataList;
  List<String> question = [];
  List<String> answer = [];
  List<String> ids = [];
  int count = 0;
  bool loading = true;

  // <summary> Load data from database </summary>
  loadData() async{
    firestoreInstance.collection("question").get().then((querySnapshot) {
      print(querySnapshot.docs);
      querySnapshot.docs.forEach((result) {
        setState(() {
          dataList = result.data();
          //question.add(dataList['question']);
          answer.add(dataList['answer']);
          count++;
        });
      });
      setState(() {
        loading = false;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }


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
                textBottom: "Available solutions here...",
                offset: 10.0,
                heights: 220.0,
                topVal: 0.0,
                leftVal: 15.0,
              ),
              // home and Add question buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child:
                loading ? Text("Solutions are Loading") : Column (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: count,
                        physics:  ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return TopicCard(
                            number: index+1,
                            titles: answer[index].toString(),
                            id: "1",
                          );
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
          ),
          child: new Icon(Icons.add),
          backgroundColor: Colors.indigo,
          onPressed: () {
            // navigate to Answer.dart
          },
        ),
      ),
    );
  }
}
