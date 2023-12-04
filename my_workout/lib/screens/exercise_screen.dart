import 'package:flutter/material.dart';
import 'package:my_workout/screens/exercise_list.dart';
import '../screens/exercise_management_screen.dart';



class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});

  static const String route = '/exercise';

  @override
  Widget build(BuildContext context) {

    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercícios cadastrados'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(ExerciseManagementScreen.route, arguments: arguments), 
            icon: const Icon(Icons.add)
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg4.jpg'),
                fit: BoxFit.cover
              ),
            ),
          ),
          ExerciseList(arguments['workoutId']),
        ],
      ),
    );
  }
}

