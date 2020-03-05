import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/Workout.dart';

class WorkoutProvider with ChangeNotifier {
  List<Workout> workouts = [];
  final url = 'https://mwlabdb.firebaseio.com/workout.json';

  Future<void> add(Workout w) async {
    final response = await http.post(url,
        body: json.encode({
          'id': w.id,
          'name': w.name,
          'imageUrl': w.imageUrl,
          'weekDay': w.weekDay
        }));
    if (response.statusCode != 200) {
      throw response.body;
    }
    notifyListeners();
  }

  Future<void> getWorkouts() async {
    workouts = [];
    final response = await http.get(url);
    final decoded = json.decode(response.body) as Map<String, dynamic>;
    decoded.forEach((id, data) {
      workouts
          .add(Workout(id, data['name'], data['imageUrl'], data['weekDay']));
    });
    notifyListeners();
  }
}
