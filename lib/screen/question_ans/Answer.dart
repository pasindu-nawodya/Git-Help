import 'package:flutter/material.dart';
import 'package:githelp/component/header/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './AnswerManager.dart';

class GiveAnswer extends StatefulWidget {
  const GiveAnswer({Key key}) : super(key: key);

  @override
  _GiveAnswerState createState() => _GiveAnswerState();
}

class _GiveAnswerState extends State<GiveAnswer> {

  final controller = ScrollController();
  String _answer;
  CollectionReference answer = FirebaseFirestore.instance.collection('answer');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> addSolution() {
    // Call the user's CollectionReference to add a new user
    return answer.add({
      'answer': _answer,
    })
        .then((value) => print("Answer Published"))
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
                textBottom: "Post your solutions",
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
                            SizedBox(height: 30.0,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text(
                                  "Provide Solution :",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,),
                                ),
                              ),
                            ),
                            SizedBox(height: 15.0,),
                            Container(
                              child: TextFormField(
                                // ignore: missing_return
                                validator: (input) {
                                  if (input.isEmpty) return 'Enter Solution';
                                },
                                onChanged: (String val){
                                  setState(() {
                                    _answer = val;
                                  });
                                },
                                decoration: InputDecoration(
                                    labelText: 'Soltion',
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.teal)),
                                    prefixIcon: Icon(Icons.description)),
                                onSaved: (input) => _answer = input,
                                minLines: 6,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            // ignore: deprecated_member_use
                            RaisedButton(
                              onPressed: addSolution,
                              padding: EdgeInsets.only(
                                  right: 80.0, left: 80.0, top: 10.0, bottom: 10.0),
                              child: Text(
                                'PUBLISH',
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
                                  MaterialPageRoute(builder: (context) => (AnswerManager())),
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

