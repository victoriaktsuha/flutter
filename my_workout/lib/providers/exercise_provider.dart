import 'dart:convert';

import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_workout/exceptions/api_exception.dart';
import '../models/exercise.dart';

class ExerciseProvider with ChangeNotifier{

  final String token;

  ExerciseProvider(this.token);


  final baseUrl = Uri.tryParse('https://workout-9c8ed-default-rtdb.firebaseio.com/exercises');

  // final List<Exercise> _list = [];

  Future<List<Exercise>> get(String workoutId) async {
    List<Exercise> exercises = [];
    final response = await http.get(Uri.parse('$baseUrl.json?auth=$token?orderBy="workoutId"&equalTo="$workoutId"'));    

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;

    // ignore: unnecessary_null_comparison
    if(decoded != null){
      decoded.forEach((key, value) {
        exercises.add(
          Exercise(
            key, 
            value['name'], 
            value['description'], 
            value['imageUrl'], 
            value['workoutId']
          )
        );
      });
    }
    return exercises;
  }

  Future<void> add(Exercise e) async {
    try{
      final response = await http.post(
        Uri.parse('$baseUrl.json?auth=$token'),
        body: json.encode({
          'name': e.name,
          'description': e.description,
          'imageUrl': e.imageUrl,
          'workoutId': e.workoutId,
        })
      );
      if(response.statusCode !=200){
        // final message = json.decode(response.body);
        throw ApiException(response.statusCode, response.body);
      }
      notifyListeners();
    } on ApiException catch(api){
      throw '${api.code}-${api.message}';
    }catch (e) {
      // throw e.message;
      // throw e.toString();
    }
  }

  Future<void> delete(String id) async {
    final response = await http.post(Uri.parse('$baseUrl/$id.json?auth=$token'));

    if(kDebugMode){
      print(response.statusCode);
    }
    
    notifyListeners();
  }

}