import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/Workout.dart';

class WorkoutProvider with ChangeNotifier {
  List<Workout> workouts = [];
  final url = 'https://mwlabdb.firebaseio.com/';

  Future<void> add(Workout w) async {
    print(url + 'workout.json');
    final response = await http.post(url + 'workout.json',
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

  Future<void> update(Workout w) async {
    final response = await http.patch(url + 'workout/' + w.id + '.json',
        body: json.encode({
          'id': w.id,
          'name': w.name,
          'imageUrl': w.imageUrl,
          'weekDay': w.weekDay
        }));
    if (response.statusCode != 200) {
      throw response.body;
    }
    int index = workouts.indexWhere((i) => i.id == w.id);
    workouts[index] = w;
    notifyListeners();
  }

  Future<void> delete(String id) async {
    final response = await http.delete(url + 'workout/$id.json');
    if (response.statusCode != 200) {
      throw response.body;
    }
    int index = workouts.indexWhere((w) => w.id == id);
    workouts.removeAt(index);
    notifyListeners();
  }

  Future<void> getWorkouts() async {
    workouts = [];
    final response = await http.get(url + 'workout.json');
    final decoded = json.decode(response.body) as Map<String, dynamic>;
    decoded.forEach((id, data) {
      workouts
          .add(Workout(id, data['name'], data['imageUrl'], data['weekDay']));
    });
    notifyListeners();
  }

  Workout getById(String id) {
    return workouts.firstWhere((w) => w.id == id);
  }
}
