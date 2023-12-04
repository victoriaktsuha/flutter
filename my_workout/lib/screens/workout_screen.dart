import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/workout_providers.dart';

import '../screens/workout_management_screen.dart';

import '../widgets/app_drawer.dart';
import '../widgets/workout_card.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  static const route = '/workout';

  @override
  Widget build(BuildContext context) {

    if (kDebugMode) {
      print('build workout');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Treinos'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(WorkoutManagementScreen.route, arguments: {'title': 'Novo treino'}), 
            icon: const Icon(Icons.add)
          ),
        ],
      ),
      drawer: const AppDrawer(),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Consumer<WorkoutProvider>(
            builder: (_, provider, widget){
              return ListView.builder(
                itemCount: provider.workouts.length,
                itemBuilder: (_, index){
                  return WorkoutCard(
                    provider.workouts[index].id,
                    provider.workouts[index].imageUrl, 
                    provider.workouts[index].name, 
                    provider.workouts[index].weekDay
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}

