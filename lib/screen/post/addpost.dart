import 'package:flutter/material.dart';
import 'package:githelp/component/header/header.dart';
import 'package:githelp/screen/guide/guide.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  final controller = ScrollController();
  String _topic, _desc, _step, _command;
  CollectionReference post = FirebaseFirestore.instance.collection('post');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return post
        .add({
      'topic': _topic,
      'description': _desc,
      'step': _step ,
      'command' : _command
    })
        .then((value) => print("Post Added"))
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
              textBottom: "Share Your Knowledge",
              offset: 10.0,
              heights: 250.0,
              topVal: 0.0,
              leftVal: 20.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                "Add Topic :",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0,),
                          Container(
                            child: TextFormField(
                              // ignore: missing_return
                              validator: (input) {
                                if (input.isEmpty) return 'Enter Topic';
                              },
                              onChanged: (String val){
                                setState(() {
                                  _topic = val;
                                });
                              },
                              decoration: InputDecoration(
                                  labelText: 'Topic',
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.teal)),
                                  prefixIcon: Icon(Icons.topic)),
                              onSaved: (input) => _topic = input,
                              minLines: 2,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                            ),
                          ),
                          SizedBox(height: 30.0,),
                          Align(
                          alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                "Add Description :",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0,),
                          Container(
                            child: TextFormField(
                              // ignore: missing_return
                              validator: (input) {
                                if (input.isEmpty) return 'Enter Description';
                              },
                              onChanged: (String val){
                                setState(() {
                                  _desc = val;
                                });
                              },
                              decoration: InputDecoration(
                                  labelText: 'Description',
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.teal)),
                                  prefixIcon: Icon(Icons.description)),
                              onSaved: (input) => _desc = input,
                              minLines: 6,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                            ),
                          ),
                          SizedBox(height: 30),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                "Add Steps :",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0,),
                          Container(
                            child: TextFormField(
                              // ignore: missing_return
                              validator: (input) {
                                if (input.isEmpty)
                                  return 'Add Steps';
                              },
                              onChanged: (String val){
                                setState(() {
                                  _step = val;
                                });
                              },
                              decoration: InputDecoration(
                                  labelText: 'Separate steps by coma \n Ex: Step 1, Step 2, Step 3',
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.teal)),
                                  prefixIcon: Icon(Icons.account_tree_rounded)),
                              onSaved: (input) => _step = input,
                              minLines: 3,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                            ),
                          ),
                          SizedBox(height: 30),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                "Command :",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0,),
                          Container(
                            child: TextFormField(
                              // ignore: missing_return
                              validator: (input) {
                                if (input.isEmpty)
                                  return 'Add command';
                              },
                              onChanged: (String val){
                                setState(() {
                                  _command = val;
                                });
                              },
                              decoration: InputDecoration(
                                  labelText: 'Command',
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.teal)),
                                  prefixIcon: Icon(Icons.comment_bank)),
                              onSaved: (input) => _command = input,
                            ),
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          // ignore: deprecated_member_use
                          RaisedButton(
                            onPressed: addUser,
                            padding: EdgeInsets.only(
                                right: 80.0, left: 80.0, top: 10.0, bottom: 10.0),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            color: Colors.indigo,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                          SizedBox(height: 30.0,),
                          RaisedButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => (GuideList())),
                              );
                            },
                            padding: EdgeInsets.only(
                                right: 87.0, left: 87.0, top: 10.0, bottom: 10.0),
                            child: Text(
                              ' Back ',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            color: Colors.indigo[300],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
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
