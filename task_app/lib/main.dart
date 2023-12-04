import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(49, 47, 100, 1),
        // accentColor:  const Color.fromRGBO(252, 92, 99, 1),
        cupertinoOverrideTheme: const CupertinoThemeData(
          barBackgroundColor: Color.fromRGBO(49, 47, 100, 1),
          textTheme: CupertinoTextThemeData(
            navTitleTextStyle: TextStyle(
              fontFamily: 'Playfair Display',
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          primaryColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'Righteous'
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color.fromRGBO(49, 47, 100, 1),
        )
      ),
      home: Home(),
    );
  }
}
