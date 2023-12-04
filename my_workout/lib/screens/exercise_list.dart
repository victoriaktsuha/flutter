import 'package:flutter/material.dart';
import '../providers/exercise_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/exercise_card.dart';

class ExerciseList extends StatelessWidget {

  final String workoutId;

  const ExerciseList(this.workoutId, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ExerciseProvider>(context).get(workoutId), 
      builder: (_, snapshot){
        return snapshot.connectionState == ConnectionState.done 
        ? ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (_, index){
            return ExerciseCard(
              snapshot.data![index].id as String, 
              snapshot.data![index].name as String, 
              snapshot.data![index].description as String, 
              snapshot.data![index].imageUrl as String 
            );
          },
        ) 
        : const Center(child: CircularProgressIndicator());            
      },
    );
  }
}