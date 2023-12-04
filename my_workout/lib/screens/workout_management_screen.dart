// import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:core';

import '../providers/workout_providers.dart';

import '../models/workout.dart';

class WorkoutManagementScreen extends StatefulWidget {
  const WorkoutManagementScreen({super.key});

  static const String route = '/workout-management';

  @override
  // ignore: library_private_types_in_public_api
  _WorkoutManagementScreenState createState() => _WorkoutManagementScreenState();
}

class _WorkoutManagementScreenState extends State<WorkoutManagementScreen> {

  Workout _workout = Workout();
  final _imageFocus = FocusNode();
  final _dropDownFocus = FocusNode();
  final _form = GlobalKey<FormState>();

  bool _dropDownValid = true;
  int? _dropDownValue;
  bool isInit = true;

  final List<Map<String, Object>> _dropDownOptions = [
    {'id': 1, 'name':'Segunda'},
    {'id': 2, 'name':'Terça'},
    {'id': 3, 'name':'Quarta'},
    {'id': 4, 'name':'Quinta'},
    {'id': 5, 'name':'Sexta'},
    {'id': 6, 'name':'Sábado'},
    {'id': 7, 'name':'Domingo'},
  ];

  void _save(context) async{
    try{
      if(_dropDownValue! > 0){
        setState(() {
          _dropDownValid = true;
        });
      }else{
        setState(() {
          _dropDownValid = false;
        });
      }
      bool valid = _form.currentState!.validate();
      if(valid && _dropDownValid){
        _form.currentState!.save();
        _workout.weekDay = _dropDownValue;

        if(_workout.id != null){
          await Provider.of<WorkoutProvider>(context, listen: false).update(_workout);
        }else{
          await Provider.of<WorkoutProvider>(context, listen: false).add(_workout);
        }
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      }
    } catch (e){  
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  // Flutter Life cycles

  // ocorre quando o Flutter constrói o widget
  @override
  void initState(){
    super.initState();
    if (kDebugMode) {
      print('init state');
    }
  }

  // ocorre após a construção, quando o widget carrega pela primeira vez ou quando tem uma dependencia externa que foi alterada
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    if(kDebugMode){
      if(isInit){
        final arguments = ModalRoute.of(context)?.settings.arguments as Map;
        if(arguments['id'] != null){
          _workout = Provider.of<WorkoutProvider>(context, listen: false).getById(arguments['id']);
          _dropDownValue = _workout.weekDay;
        }
      }
    }
    isInit = false;
  }

  void _delete() async {
    Navigator.of(context).pop();    
    await Provider.of<WorkoutProvider>(context, listen: false).delete(_workout.id as String);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();    
  }

  // ocorre quando irá acontecer uma atualização no widget, trazendo o widget antigo para fins de comparação
 /*  @override
  void didUpdateWidget(WorkoutManagementScreen oldWidget){
    super.didUpdateWidget(oldWidget);
    if(kDebugMode){
      print('did update');
    }
  } */

  // ocorre quando o widget 'começa a morrer', quando o Flutter identifica que precisará destruir o widget e remove-lo da 'arvore de widgets'
 /*  @override
  void deactivate(){
    super.deactivate();
    if(kDebugMode){
      print('deactivate');
    }
  } */

  // ocorre depois que o widget foi destruído e não será mais construído - utlizado com submit, animações, etc
  /* @override
  void dispose(){
    super.dispose();
    if(kDebugMode){
      print('dispose');
    }
  } */

  void _showConfirmationModal(){
    showDialog(context: context, builder: (_) {
      return AlertDialog(
        title: const Text('Deseja remover treino ? '),
        content: const Text('Essa ação não poderá ser desfeita'),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: const Text('Cancelar'),
          ),
          OutlinedButton(
            onPressed: _delete, 
            child: const Text('Sim, continuar'),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
  // build também é um life cycle - retornando o widget com os elementos construídos a serem exibidos em tela
    if(kDebugMode){
      print('build');
    }

    final arguments = 
      ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments['title']),
        actions: _workout.id != null ? [
          IconButton(
            onPressed: _showConfirmationModal, 
            icon: const Icon(Icons.delete)
          )
        ] 
        : [],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg4.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _form,
              child: ListView(
                children: [
                  TextFormField(
                    initialValue: _workout.name,
                    onSaved: (value) => _workout.name = value,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_imageFocus),
                    decoration: const InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if(value!.isEmpty || value.length < 3){
                        return 'O nome deve conter pelo menos 3 caracteres';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: _workout.imageUrl,
                    onSaved: (value) => _workout.imageUrl = value,
                    focusNode: _imageFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_dropDownFocus),
                    decoration: const InputDecoration(labelText: 'Imagem URL'),
                    validator: (value) {
                      if(!value!.startsWith('https://') && !value.startsWith('http://')){
                        return 'Endereço de imagem inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 0.5,
                  ),
                  DropdownButtonHideUnderline(
                    child: Container(
                      color: Theme.of(context).inputDecorationTheme.fillColor,
                      padding: const EdgeInsets.all(15),
                      child: DropdownButton(
                        value: _dropDownValue,
                        focusNode: _dropDownFocus,
                        items: _dropDownOptions.map(
                          (e) => DropdownMenuItem(
                            value: e['id'],
                            child: Text(e['name'] as String), 
                          ),
                        ).toList(), 
                        onChanged: (value) {
                          setState(() {
                            _dropDownValue = value as int;
                          });
                        },
                        hint: Text('Dia da semana', style: TextStyle(
                          color: Theme.of(context).textTheme.titleSmall?.color,
                        ),
                        ),
                        icon: const Icon(Icons.calendar_today),
                        isExpanded: true,
                        iconEnabledColor: Theme.of(context).colorScheme.secondary,
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                          color: Theme.of(context).textTheme.displayLarge?.color,
                        ),
                        dropdownColor: const Color.fromRGBO(48, 56, 62, 0.9),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _dropDownValid 
                      ? '' 
                      : 'Selecione um dia da semana', 
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: 
                    Builder(
                      builder: (context) {
                        return ElevatedButton(
                          onPressed: () => _save(context), 
                          child: Text('Salvar', 
                            style: TextStyle(
                              color: Theme.of(context).textTheme.displayLarge?.color,
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}