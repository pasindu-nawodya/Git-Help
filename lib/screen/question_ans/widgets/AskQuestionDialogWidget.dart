import 'package:flutter/material.dart';
import './QuestionFormWidget.dart';

class AskQuestionDialogWidget extends StatefulWidget {
  @override
  _AskQuestionDialogWidgetState createState() => _AskQuestionDialogWidgetState();
}

class _AskQuestionDialogWidgetState extends State<AskQuestionDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String question = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Type question here',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),
        ),
        const SizedBox(height: 8,),

        // <summary> Question input fields </summary>
        QuestionFormWidget(
          onChangeQuestion:(question) => setState(() => this.question = question),
          onSavedQuestion:() {},
        )
      ],
    ),
  );
}
