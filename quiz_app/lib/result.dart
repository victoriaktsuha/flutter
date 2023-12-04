import 'package:flutter/widgets.dart';

class Result extends StatelessWidget{

  final String message;
  final Function reset;

  Result(this.message, this.reset);

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(message),
          ],
        ),
        Row(
          children: <Widget>[
            RaisedButton(
              onPressed: this.reset,
              child: Text('Voltar'),
            ),
          ],
        ),
      ],
    );
  }
}