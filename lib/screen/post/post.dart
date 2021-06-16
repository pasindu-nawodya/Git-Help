import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:githelp/component/command/command.dart';
import 'package:githelp/component/header/header.dart';
import 'package:githelp/screen/guide/guide.dart';


class Post extends StatefulWidget {
  String title;
  String desc;
  String step;
  String comm;
  String pid;
  Post(this.title,this.desc,this.step,this.comm,this.pid);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  final controller = ScrollController();
  List<String> stepList;
  String postId,topic;
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stepList = widget.step.split(",");
    topic = widget.title;
    //postId = widget.pid;
  }

  deletePost() async{
    await firestoreInstance.collection("post").where("topic", isEqualTo : topic).get().then((value){
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection("post").doc(element.id).delete().then((value){
          print("Success!");
        });
      });
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => (GuideList())),
    );
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
              textBottom: "More Details About Topic",
              offset: 10.0,
              heights: 250.0,
              topVal: 0.0,
              leftVal: 5.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15.0,)
                  ]
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  SizedBox(height: 10),
                  Text(
                    widget.desc,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Steps :",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: stepList.length,
                      physics:  ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Text(
                          "•  "+stepList[index],
                          style: TextStyle(fontSize: 18.0),
                        );
                      }),
                  SizedBox(height: 20),
                  Text(
                    "Command :",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  SizedBox(height: 10),
                  Command(
                    title: widget.comm,
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
                                MaterialPageRoute(builder: (context) => (GuideList())),
                              );
                            },
                            backgroundColor: Colors.indigo,
                            child: const Icon(Icons.list),
                          ),
                          SizedBox(width: 10.0,),
                          FloatingActionButton(
                            onPressed: (){
                              deletePost();
                            },
                            backgroundColor: Colors.indigo,
                            child: const Icon(Icons.delete),
                          )
                        ],
                      )
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
