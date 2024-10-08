import 'package:flutter/material.dart';

class CustomPageTransition extends MaterialPageRoute{
  CustomPageTransition({required super.builder});

  @override
  Widget buildTransitions(
    BuildContext context, 
    Animation<double> animation, 
    Animation<double> secondaryAnimation, 
    Widget child) {

    return FadeTransition(
      opacity: animation, 
      child: child
    );
  }

}

class CustomPageTransitionBuilder extends PageTransitionsBuilder{
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route, 
    BuildContext context, 
    Animation<double> animation, 
    Animation<double> secondaryAnimation, 
    Widget child) {
      
    return FadeTransition(
      opacity: animation, 
      child: child
    );
  }

}