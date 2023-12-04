import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  // ignore: prefer_typing_uninitialized_variables
  final title;

  const Home(this.title, {super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home>{
  int valor = 0;

  void click(){
    setState(() {
      valor++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('Home build');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Você pressionou o botão vezes.'),
            Text('$valor')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: click, child:Icon(Icons.add)),
    );
  }

}