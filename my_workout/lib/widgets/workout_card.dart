// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_workout/screens/workout_management_screen.dart';
import '../screens/exercise_screen.dart';
import '../widgets/workout_screen_custom_clipper.dart';

import '../utils/Utils.dart';

class WorkoutCard extends StatelessWidget {
  
  final String? id;
  final String? imageUrl;
  final String? name;
  final int? weekDay;

  const WorkoutCard(this.id, this.imageUrl, this.name, this.weekDay, {super.key});

  @override
  Widget build(BuildContext context) {

    final MediaQueryData mediaQuery = MediaQuery.of(context);
    
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(WorkoutManagementScreen.route, arguments: {'title':'Editando $name', 'id': id}),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          children: [
            SizedBox(
              width: mediaQuery.size.width * 0.4,
              child: ClipPath(
                clipper: WorkoutScreenCustomClipper(),
                child: Image(
                  image: NetworkImage(imageUrl as String),
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name as String, 
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    Utils.getWeekdayName(weekDay),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pushNamed(ExerciseScreen.route, arguments: {'workoutId' : id}), 
                        style: const ButtonStyle(
                          side: MaterialStatePropertyAll(
                            BorderSide(
                              color: Color.fromRGBO(0, 223, 100, 1)
                            ),
                          ),
                        ),
                        child: const Text('Exercícios'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}