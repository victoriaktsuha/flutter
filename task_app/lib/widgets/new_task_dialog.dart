import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../adaptive/adaptive_button.dart';
import 'package:task_app/models/task.dart';

class NewTaskDialog extends StatelessWidget{

  final Function _saveTask;

  NewTaskDialog(this._saveTask);

  static final _tiltleController = TextEditingController();
  static final _descriptionController = TextEditingController();

  final Widget _title = Platform.isIOS 
  ? CupertinoTextField(
    placeholder: 'Título', 
    controller: _tiltleController,) 
  : TextField(
    decoration: InputDecoration(labelText: 'Título'), 
    controller: _tiltleController,
  );

  final Widget _description = Platform.isIOS 
    ? CupertinoTextField(
      placeholder: 'Descrição',
      controller: _descriptionController,
      minLines: 5,
      maxLines: 10,
    )
    : TextField(
      decoration: const InputDecoration(labelText: 'Descrição'),
      controller: _descriptionController,
      minLines: 5,
      maxLines: 10,
    );


  @override
  Widget build(BuildContext context) {

    // ignore: no_leading_underscores_for_local_identifiers
    void _handleSave(){
      final Task task = Task(_tiltleController.text, _descriptionController.text, false);

      _tiltleController.clear();
      _descriptionController.clear();
      _saveTask(task);
      Navigator.of(context).pop();
    }

    return Platform.isIOS 
    ? CupertinoAlertDialog(
      title: const Text('Adicionar tarefa'), 
      content: Column(
        children: <Widget>[_title, _description],
      ), 
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: _handleSave,
          child: const Text('Salvar'), 
          )
        ], 
      ) 
    : AlertDialog(
      title: const Text('Adicionar tarefa'), 
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _title, 
          _description
        ],
      ), 
      actions: <Widget>[
        AdaptiveButton(
          text: 'Salvar',
          callback: _handleSave,
        )
        // RaisedButton(
        //   child: Text('Salvar'), 
        //   onPressed: _handleSave,
        // ),
      ],
    );
  }
}