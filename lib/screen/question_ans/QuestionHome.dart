import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:githelp/component/header/header.dart';
import 'package:githelp/component/topic-card/topic-card.dart';

import './widgets/AskQuestionDialogWidget.dart';
import 'package:provider/provider.dart';
import '../../provider/Questions.dart';
import './Question.dart';
import './AnswerManager.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class QuestionHome extends StatefulWidget {
  const QuestionHome({Key key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _QuestionState();
  }
}

class _QuestionState extends State<QuestionHome> {

  final controller = ScrollController();
  final firestoreInstance = FirebaseFirestore.instance;

  Map<String,dynamic> dataList;
  List<String> question = [];
  List<String> ids = [];
  int count = 0;
  bool loading = true;

  loadData() async{
    firestoreInstance.collection("question").get().then((querySnapshot) {
      print(querySnapshot.docs);
      querySnapshot.docs.forEach((result) {
        setState(() {
          dataList = result.data();
          question.add(dataList['question']);
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

  //-----------------------------------------------------------------------------------------------------
  // <summary> Delete Question </summary>                         // NEED TO FIND THE ID / STRING OF SELECTING CARD
  deleteQuestion() async{
    await firestoreInstance.collection("question").where("question",isEqualTo : "What is a branch ?").get().then((value){
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection("question").doc(element.id).delete().then((value){
          print("Question Removed");
        });
      });
    });
    print('delete executed..');
  }
  //-----------------------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => QuestionProvider(),

    child: Scaffold(

      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: <Widget>[
            MyHeader(
              image: "",
              textTop: "",
              textBottom: "Feel free to ask...",
              offset: 10.0,
              heights: 220.0,
              topVal: 0.0,
              leftVal: 65.0,
            ),
            // home and Add question buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child:
              loading ? Text("Questions are Loading") : Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: count,
                      physics:  ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                           child : Slidable (
                              actionPane: SlidableDrawerActionPane(),
                              actions: [
                                IconSlideAction(
                                  color: Colors.red,
                                  caption: 'Remove',
                                  icon: Icons.delete,
                                  onTap: () {
                                    // define delete function
                                    deleteQuestion();
                                  },
                                )
                              ],
                              child: TopicCard(
                                number: index+1,
                                titles: question[index].toString(),
                                id: "1",
                                widget: AnswerManager(),
                              ),
                            )
                        );
                      }),
                ],
              ),
            ),
            SizedBox(height: 30),
            Align(
                alignment: Alignment(0.9, 0.5),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 230.0,),
                    FloatingActionButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => (AskQuestion())),
                        );
                      },
                      backgroundColor: Colors.indigo,
                      child: const Icon(Icons.add),
                    ),
                    SizedBox(width: 10.0,),
                    FloatingActionButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => (AnswerManager())),
                        );
                      },
                      backgroundColor: Colors.indigo,
                      child: const Icon(Icons.home),
                    )
                  ],
                )
            ),
            SizedBox(height: 20.0,)
          ],
        ),
      ),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>  showDialog (                               // REMOVE THE SHOW DIALOG
            context: context,
            barrierDismissible: true,
            // <summary> Load AskQuestionDialog </summary>
            builder: (context) => AskQuestion()
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
        ),
        child: new Icon(Icons.add),
        backgroundColor: Colors.indigo,
      ),
      */
    ),
  );
}
