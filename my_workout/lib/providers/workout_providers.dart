import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import '../exceptions/api_exception.dart';

import '../models/workout.dart';


class WorkoutProvider with ChangeNotifier{

  final String userId;
  final String token;

  WorkoutProvider(this.userId, this.token);

  List<Workout> workouts = [];

  final baseUrl = Uri.parse('https://workout-9c8ed-default-rtdb.firebaseio.com/workouts');

  Future<List<Workout>> get() async{
    try{
      workouts = [];
      final response = await http.get(Uri.parse('$baseUrl.json?auth=$token&orderBy="userId"&equalTo="$userId"'));

      if(response.statusCode != 200){
        // final message = json.decode(response.body) as Map;
        throw ApiException(response.statusCode, response.body);
      }

      final decoded = json.decode(response.body) as Map;
    
      // ignore: unnecessary_null_comparison
      if(decoded != null){
        decoded.forEach((key, value) {
          workouts.add(
            Workout(
              key, 
              value['name'], 
              value['imageUrl'], 
              value['weekday']
            )
          );
        });
      }

      return workouts;

    } on ApiException catch (api) {
      throw '${api.code} - ${api.message}';
    } /* catch (e){
      throw e.messages;
    } */
    
  }

  Future<void> add(Workout w) async{
    try{
      final response = await http.post(
        Uri.parse('$baseUrl.json?auth=$token'), 
        body: json.encode({
          'name': w.name,
          'imageUrl': w.imageUrl,
          'weekDay': w.weekDay,
          'userId': userId,
        })
      );

      w.id = json.decode(response.body)['name'];
      workouts.add(w);

      notifyListeners();
    } catch (e) {
      // throw e.message;
      // throw e.toString();
    } 
  }

  Future<void> update(Workout w) async{
    final response = await http.put(
      Uri.parse('$baseUrl/${w.id}.json?auth=$token'), 
      body: json.encode({
        'name': w.name,
        'imageUrl': w.imageUrl,
        'weekDay': w.weekDay
    }));

    if(kDebugMode){
      print(response.statusCode);
    }

    final index = workouts.indexWhere((element) => element.id == w.id);
    workouts[index] = w;

    notifyListeners();
  }

  Future<void> delete(String id) async{
    final response = await http.delete(Uri.parse('$baseUrl/$id.json?auth=$token'));
    workouts.removeWhere((element) => element.id == id);

    if(kDebugMode){
      print(response.statusCode);
    }
    notifyListeners();
  }

  Workout getById(String id){
    return workouts.firstWhere((element) => element.id == id);
  }
}