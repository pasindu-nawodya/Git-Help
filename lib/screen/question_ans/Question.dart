import 'package:flutter/material.dart';
import 'package:githelp/component/header/header.dart';
import 'package:githelp/screen/question_ans/QuestionHome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AskQuestion extends StatefulWidget {
  const AskQuestion({Key key}) : super(key: key);

  @override
  _AskQuestionState createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {

  final controller = ScrollController();
  String _question;
  String _answer;
  CollectionReference question = FirebaseFirestore.instance.collection('question');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  // <sumarry> database field </summary>
  Future<void> addQuestion() {
    // Call the user's CollectionReference to add a new user
    return question.add({
      'question': _question,
      'answer': _answer,
    })
        .then((value) => print("Question Saved"))
        .catchError((error) => print(error));
  }

  // <summary> show error message </summary>
  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Something went wrong!'),
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
                textBottom: "Ask questions here...",
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
                                  "Add Question :",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,),
                                ),
                              ),
                            ),
                            SizedBox(height: 15.0,),
                            Container(
                              child: TextFormField(
                                // ignore: missing_return
                                validator: (input) {
                                  if (input.isEmpty) return 'Please insert your question';
                                },
                                onChanged: (String val){
                                  setState(() {
                                    _question = val;
                                    _answer = '';
                                  });
                                },
                                decoration: InputDecoration(
                                    labelText: 'Question',
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.teal)),
                                    prefixIcon: Icon(Icons.topic)),
                                onSaved: (input) => _question = input,
                                minLines: 2,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            ),

                            SizedBox(
                              height: 50.0,
                            ),
                            // ignore: deprecated_member_use
                            RaisedButton(
                              onPressed: addQuestion,
                              padding: EdgeInsets.only(
                                  right: 80.0, left: 80.0, top: 10.0, bottom: 10.0),
                              child: Text(
                                'Publish',
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
                                  MaterialPageRoute(builder: (context) => (QuestionHome())), // Navigate to question form
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

