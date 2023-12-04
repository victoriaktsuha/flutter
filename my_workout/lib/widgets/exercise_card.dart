import 'package:flutter/material.dart';
import '../providers/exercise_provider.dart';
import 'package:provider/provider.dart';

class ExerciseCard extends StatelessWidget {
  final String? id;
  final String? name;
  final String? description;
  final String? imageUrl;
  
  const ExerciseCard(this.id, this.name, this.description, this.imageUrl, {super.key,});

  void _delete(BuildContext context) async{
    await Provider.of<ExerciseProvider>(context, listen: false).delete(id as String);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          name as String,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description as String,
          style: TextStyle(
            color: Theme.of(context).textTheme.titleSmall?.color
          ),  
        ),
        leading: FadeInImage(
          height: 50,
          width: 50,
          fit: BoxFit.cover,
          placeholder: const AssetImage('assets/images/halter.png'),
          image: NetworkImage(
            imageUrl as String,

          ),
        ),
        trailing: IconButton(
          onPressed: () => _delete(context), 
          icon: const Icon(Icons.delete),
          color: Colors.red,
        ),
      ),
    );
  }
}