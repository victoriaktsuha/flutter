import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptiveButton extends StatelessWidget{

  final String text;
  final Function callback;
  final double padding;

  const AdaptiveButton({super.key, required this.text, required this.callback, required this.padding});


  @override
  Widget build(BuildContext context) {
    return Platform.isIOS 
    ? CupertinoButton(
      padding: EdgeInsets.all(padding), 
      onPressed: callback,
      child: Text(text),
      )
    : ElevatedButton(
      onPressed: callback,
      child: Text(text), 
    );
  }
}