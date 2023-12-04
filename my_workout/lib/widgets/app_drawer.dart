import 'package:flutter/material.dart';
import 'package:my_workout/helpers/custom_page_transition.dart';
import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'dart:core';

import '../screens/home_screen.dart';
import '../screens/workout_screen.dart';

class AppDrawer extends StatelessWidget{
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromRGBO(29, 36, 41, 0.8),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(
                Icons.home, 
                color: Theme.of(context).colorScheme.secondary
              ),
              title: const Text('Home'),
              onTap: () => 
                Navigator.of(context).pushNamed(HomeScreen.route),
            ),
            ListTile(
              leading: Icon(
                Icons.fitness_center,
                color: Theme.of(context).colorScheme.secondary,  
              ),
              title: const Text('Treinos'),
              onTap: () => 
                Navigator.of(context).pushNamed(WorkoutScreen.route),
                // Navigator.of(context).push(
                //   CustomPageTransition(
                //     builder: (_) => const WorkoutScreen()
                //   )
                // )
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.secondary,  
              ),
              title: const Text('Sair'),
              onTap: (){
                Provider.of<AuthProvider>(context, listen: false).logout();
                Navigator.of(context).popUntil((route){
                  if(route.settings.name == '/'){
                    return true;
                  }
                  return false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
