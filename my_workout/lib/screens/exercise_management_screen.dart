// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../providers/exercise_provider.dart';
import 'package:provider/provider.dart';

class ExerciseManagementScreen extends StatefulWidget {
  const ExerciseManagementScreen({super.key});

  static const String route = '/exercise-management';

  @override
  State<ExerciseManagementScreen> createState() => _ExerciseManagementScreenState();
}

class _ExerciseManagementScreenState extends State<ExerciseManagementScreen> {
  final Exercise _exercise = Exercise();
  final _imageFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _form = GlobalKey<FormState>();

  bool isInit = true;

  Future<void> _save() async {
    try{
      bool valid = _form.currentState!.validate();

      if(valid){
        _form.currentState!.save();

        await Provider.of<ExerciseProvider>(context, listen: false).add(_exercise);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      }
    } catch (e){
      // ignore: use_build_context_synchronously
      showDialog(
        context: context, 
        builder: (_){
          return AlertDialog(
            title: const Text('Falha ao registrar'),
            content: Text('$e'),
          );
        }
      );

    }
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    if(isInit){
      final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _exercise.workoutId = arguments['workoutId'];
    }
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar novo exercício'),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg4.jpg'),
                fit: BoxFit.cover
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _form,
              child: ListView(
                children: [
                  TextFormField(
                    onSaved: (value)=> _exercise.name = value,
                    decoration: const InputDecoration(
                      labelText: 'Nome' 
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value){
                      if(value!.length < 3){
                        return 'O nome deve conter no mínimo 3 caractéres';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_imageFocus),
                  ),
                  TextFormField(
                    onSaved: (value) => _exercise.imageUrl = value,
                    decoration: const InputDecoration(
                      labelText: 'Imagem URL',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value){
                      if(!value!.startsWith('https://') && !value.startsWith('http://')){
                        return 'Informe um endereço de imagem válido';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_descriptionFocus),
                  ),
                  TextFormField(
                    onSaved: (value) => _exercise.description = value,
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                    ),
                    focusNode: _descriptionFocus,
                    maxLength: 200,
                    minLines: 3,
                    maxLines: 5,
                    buildCounter: (_, {required currentLength, required isFocused, required maxLength}) => Text('$currentLength/$maxLength', style: const TextStyle(color: Colors.white),
                    ),
                    validator: (value){
                      if(value!.length < 5){
                        return 'A descrição deve conter no mínimo 5 caractéres';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_descriptionFocus),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _save, 
                      child: Text('Salvar', style: TextStyle(color: Theme.of(context).textTheme.displayLarge?.color),
                      ),                     
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