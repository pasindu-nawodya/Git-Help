import 'package:flutter/material.dart';

class QuestionFormWidget extends StatelessWidget {

  final String question;
  final ValueChanged<String> onChangeQuestion;
  final VoidCallback onSavedQuestion;


  const QuestionFormWidget({
    Key key,
    this.question = '',
    @required this.onChangeQuestion,
    @required this.onSavedQuestion
  }) : super(key:key);


  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildQuestion(),
        buildButton(),
      ],
    ),
  );

  Widget buildQuestion() => TextFormField(

    maxLines: 1,
    onChanged: onChangeQuestion,
    validator: (question){
      if(question.isEmpty){
        return 'Please insert the question';
      }
      return null;
    },
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Question'
    ),
  );


  Widget buildButton() => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.indigo)
      ),
      onPressed: onSavedQuestion,
      child: Text('S U B M I T'),
    ),
  );

}
