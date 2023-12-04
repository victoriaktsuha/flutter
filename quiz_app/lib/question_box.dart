import 'package:flutter/material.dart';

class QuestionBox extends StatelessWidget{

  final _index;
  final _questions;
  final Function nextQuestion;

  QuestionBox(this._index, this._questions, this.nextQuestion);

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[Expanded(child: Text('Selecione a afirmação correta', 
          textAlign: TextAlign.center,))]
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: RaisedButton(
                onPressed: () => this.nextQuestion(_questions[_index][_index][0].value), 
                color: Colors.blue, 
                textColor: Colors.white,
                child: Text(_questions[_index][_index][0].question),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(child: Text('OU', textAlign: TextAlign.center,)),],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: RaisedButton(
                onPressed: () => this.nextQuestion(_questions[_index][_index][1].value), 
                color: Colors.red, 
                textColor: Colors.white,
                child: Text(_questions[_index][_index][1].question),
              ),
            ),
          ],
        ),
      ],
    );
  }
}