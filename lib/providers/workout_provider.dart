import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/Workout.dart';

class WorkoutProvider with ChangeNotifier {
  final String _token;
  final String _userId;

  List<Workout> workouts = [];
  final url = 'https://mwlabdb.firebaseio.com/workout';

  WorkoutProvider(this._token, this._userId);

  Future<void> add(Workout w) async {
    final response = await http.post(url + '.json?auth=$_token',
        body: json.encode({
          'id': w.id,
          'name': w.name,
          'imageUrl': w.imageUrl,
          'weekDay': w.weekDay,
          'userId': _userId
        }));
    if (response.statusCode != 200) {
      throw response.body;
    }
    notifyListeners();
  }

  Future<void> update(Workout w) async {
    final response = await http.patch(url + '/${w.id}.json?auth=$_token',
        body: json.encode({
          'id': w.id,
          'name': w.name,
          'imageUrl': w.imageUrl,
          'weekDay': w.weekDay,
          'userId': _userId
        }));
    if (response.statusCode != 200) {
      throw response.body;
    }
    int index = workouts.indexWhere((i) => i.id == w.id);
    workouts[index] = w;
    notifyListeners();
  }

  Future<void> delete(String id) async {
    final response = await http.delete(url + '/$id.json?auth=$_token');
    if (response.statusCode != 200) {
      throw response.body;
    }
    int index = workouts.indexWhere((w) => w.id == id);
    workouts.removeAt(index);
    notifyListeners();
  }

  Future<void> get() async {
    workouts = [];
    final response = await http
        .get(url + '.json?auth=$_token&orderBy="userId"&equalTo="$_userId"');
    final decoded = json.decode(response.body) as Map<String, dynamic>;
    decoded.forEach((id, data) {
      workouts.add(Workout(
          id, data['name'], data['imageUrl'], data['weekDay'], data['userId']));
    });

    notifyListeners();
  }

  Workout getById(String id) {
    return workouts.firstWhere((w) => w.id == id);
  }
}
