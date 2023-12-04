import 'package:flutter/material.dart';
import 'package:my_workout/screens/exercise_list.dart';
import 'package:provider/provider.dart';

import '../models/workout.dart';
import '../providers/workout_providers.dart';
import '../widgets/app_drawer.dart';
import '../widgets/today_workout.dart';
import '../utils/Utils.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  static const route = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool _selected = true;

  int _weekDay = DateTime.now().weekday;

  List<ElevatedButton> _getButtonBar(){
    List<ElevatedButton> list = [];
    for(int i = 1; i < 8; i++){
      list.add(
        ElevatedButton(
          // ignore: avoid_print
          onPressed: (){
            setState(() {
              _weekDay = i;
              _selected = !_selected;
            });
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: const BorderSide(
                style: BorderStyle.solid,
                color: Color.fromRGBO(0, 223, 100, 1),
                ),

            ),
            // foregroundColor: Colors.white,
            // backgroundColor: const Color.fromRGBO(0, 223, 100, 1),
            foregroundColor: _weekDay == i ? Colors.white : const Color.fromRGBO(0, 223, 100, 1),
            backgroundColor: _weekDay == i ? const Color.fromRGBO(0, 223, 100, 1) : Colors.transparent,  
          ),   
          child: Text(Utils.getWeekdayName(i).substring(0, 3)
          ),
        )
      );
    }
    return list;
  }

  Widget _getTodayWorkout(List<Workout> workouts){
    final index = workouts.indexWhere((element) => element.weekDay == _weekDay);
    if (index != -1){
      return TodayWorkout(workouts[index].name??'', workouts[index].imageUrl??'');
    }else{
      return const Center(
        child: Text('Nenhum treinamento encontrado para o dia selecionado', style: TextStyle(
          color: Colors.white),
        ),
      );
    }
  }

  Widget _getExerciseList(List<Workout> workouts){
    final index = workouts.indexWhere((element) => element.weekDay == _weekDay);
    if (index != -1){
      return Expanded(child: ExerciseList(workouts[index].id??''));
    }else{
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Home')
      ), 
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
          FutureBuilder(
            future: Provider.of<WorkoutProvider>(context, listen: false).get(), 
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.error != null){
                  return Center(
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.error, 
                            color: Colors.red, 
                            size: 80,
                          ),
                          Text('${snapshot.error}', 
                            style: const TextStyle(
                              color:Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }else{
                  return Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Consumer<WorkoutProvider>(
                      builder: (_, provider, widget){
                        return Column(
                          children: [
                            widget as Widget,                       
                            _getTodayWorkout(provider.workouts),
                            _getExerciseList(provider.workouts)
                          ],
                        );
                      },
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ButtonBar(
                          children: _getButtonBar(),
                        ),
                      ),
                    ),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}