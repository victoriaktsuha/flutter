import 'package:flutter/material.dart';
import './home.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    print('MyApp build');
    return MaterialApp(
      title:'Hello World',
      home: Home('Olá mundo!'),
    );
  }
}