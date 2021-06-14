import 'package:flutter/material.dart';
import 'package:githelp/component/card/card.dart';

class QuestionAnswer extends StatelessWidget {
  final List<String> questions;
  //final List<String> answers;

  QuestionAnswer(this.questions);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: questions
          .map((question) => CardView(
                title: 'What is github?',
                text:
                    "Github is a version control system which allow you to build and manage project with multiple contributors",
                image: "assets/images/guide.png",
              ))
          .toList(),
    );
  }
}
