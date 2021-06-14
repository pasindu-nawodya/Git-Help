
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:githelp/component/header/header.dart';
import 'package:githelp/component/topic-card/topic-card.dart';
import 'package:githelp/loading-screen/loading-screen.dart';
import 'package:githelp/screen/home/home.dart';
import 'package:githelp/screen/post/addpost.dart';
import 'package:githelp/screen/post/post.dart';

class GuideList extends StatefulWidget {
  const GuideList({Key key}) : super(key: key);

  @override
  _GuideListState createState() => _GuideListState();
}

class _GuideListState extends State<GuideList> {
  final controller = ScrollController();
  final firestoreInstance = FirebaseFirestore.instance;

  Map<String,dynamic> dataList;
  List<String> topic = [];
  List<String> desc = [];
  List<String> step = [];
  List<String> command = [];
  List<String> ids = [];
  int count = 0;
  bool loading = true;

  loadData() async{
    firestoreInstance.collection("post").get().then((querySnapshot) {
      print(querySnapshot.docs);
      querySnapshot.docs.forEach((result) {
        setState(() {
          dataList = result.data();
          topic.add(dataList['topic']);
          desc.add(dataList['description']);
          step.add(dataList['step']);
          command.add(dataList['command']);
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
              textBottom: "Find Through Topic",
              offset: 10.0,
              heights: 220.0,
              topVal: 0.0,
              leftVal: 45.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child:
              loading ? LoadingScreen() : Column (
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
                          titles: topic[index].toString(),
                          desc:desc[index].toString(),
                          stp: step[index].toString(),
                          com:command[index].toString(),
                          id: "1",
                          widget: Post(topic[index].toString(),desc[index].toString(),topic[index].toString(),topic[index].toString(),"1".toString()),
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
                          MaterialPageRoute(builder: (context) => (AddPost())),
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
                          MaterialPageRoute(builder: (context) => (Home())),
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
    ),
    );
  }
}

