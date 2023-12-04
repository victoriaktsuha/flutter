import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../models/task.dart';

class ListTask extends StatelessWidget{

  final List<Task> _listTask;
  final Function _handleSwitchChange;
  final bool _isPortrait;
  final Function _removeItem;

  const ListTask(this._listTask, this._handleSwitchChange, this._isPortrait, this._removeItem, {super.key});

  @override
  Widget build(BuildContext context){

    // ignore: no_leading_underscores_for_local_identifiers
    final int _maxLength = _isPortrait ? 80 : 180;

    // ignore: no_leading_underscores_for_local_identifiers
    _handleLongPress(String title, String description){
      showDialog(context: context, builder: (_){
        return Platform.isIOS 
        ? CupertinoAlertDialog(title: Text(title), content: Text(description),) 
        : SimpleDialog(title: Text(title), children: <Widget>[Padding(
          padding: const EdgeInsets.all(10),
          child: Text(description),
        )],);
      });    
    };

    return Material(
      child: ListView.separated(
        itemBuilder: (BuildContext (context), int index) {
          return ListTile(
            title: Text(
              _listTask[index].title, 
              style: _listTask[index].finished 
              ? TextStyle(decoration:  TextDecoration.lineThrough)
            : null
            ), 
            subtitle: _listTask[index].finished 
            ? null 
            : Text(_listTask[index].description.length > _maxLength 
                ? '${_listTask[index].description.substring(0, _maxLength)}...' 
                : _listTask[index].description
              ),
            leading: Switch.adaptive(
              value: _listTask[index].finished, 
              onChanged: (value) => _handleSwitchChange(index, value),
            ),
            onLongPress: () => _handleLongPress(_listTask[index].title, _listTask[index].description),
            trailing: IconButton(icon: Icon(Icons.delete), onPressed: () => _removeItem(index),),
          );        
        },
        itemCount: _listTask.length,
        separatorBuilder: (_, index) => Divider(),
      ),
    );
  }
}