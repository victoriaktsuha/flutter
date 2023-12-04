import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../adaptive/adaptive_button.dart';
import '../widgets/list_task.dart';

import './new_task_dialog.dart';
import '../models/task.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {

  final List<Task> _listTask = [
    Task('Compras', 'Ir ao supermercado e comprar mantimentos', false),
    Task('Mecânico', 'O carro está apresentando problemas ao ligar', false),
  ];

  void _handleSwitchChange(int index, bool value){
    setState(() {
      _listTask[index].finished = value;
    });
  }

  void _saveTask(Task task){
    setState(() {
      _listTask.add(task);
    });
  }

  void _removeItem(int index){
    setState(() {
      _listTask.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);
    final _mediaQuery = MediaQuery.of(context);
    final _isPortrait = _mediaQuery.orientation == Orientation.portrait;
    final _landscapeHeight = _mediaQuery.size.height * 0.15;
    final _portraitHeight = _mediaQuery.size.height * 0.2; 

    final _appBarHeight = _isPortrait ? _portraitHeight : _landscapeHeight;

    _handleAddPress(){
      showDialog(context: context, builder: (_){
        return NewTaskDialog(_saveTask);
      });
    }

    return Platform.isIOS 
    ? CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Task App'),
        // trailing: CupertinoButton(
        //   child: Text('Adicionar'), 
        //   onPressed: _handleAddPress,
        //   padding: EdgeInsets.all(0),
        // ),
        trailing: AdaptiveButton(
          text: 'Adicionar',
          callback: _handleAddPress,
          padding: 0.0,
        ),
      ),
      child: ListTask(_listTask, _handleSwitchChange, _isPortrait, _removeItem),
    ) : Scaffold(
      appBar: AppBar(
        title: const Text('Task App'),
        bottom: const PreferredSize(preferredSize: Size.fromHeight(100), 
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Task App', style: TextStyle(
                      color: Colors.white,
                      fontSize:  40,
                      fontFamily: 'Playfair Display',
                      fontWeight: FontWeight.bold,
                    ))
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                    DateFormat.yMMMMEEEEd('pt_BR').format(DateTime.now()),
                    style: TextStyle(
                      fontFamily: 'Playfair Display',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),)
                  ],
                ),
              ], 
            ),
          ),
        ),
        actions: const <Widget>[
          IconButton(onPressed: _handleAddPress(), icon: Icon(Icons.add))
        ],
        flexibleSpace: const Image(
          image: AssetImage('assets/images/3349370.png'),
          fit:BoxFit.cover),
      ),
      floatingActionButton: const FloatingActionButton(onPressed: _handleAddPress(), icon: Icon(Icons.add)),
      body: ListTask(_listTask, _handleSwitchChange, _isPortrait, _removeItem),
    );
  }
}
