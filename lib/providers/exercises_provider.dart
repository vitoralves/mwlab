import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/exercise.dart';

class ExercisesProvider with ChangeNotifier {
  final String url = 'https://mwlabdb.firebaseio.com/exercise';
  final List<Exercise> exercises = [];

  Future<void> get(String workoutId) async {
    final response = await http.get('$url.json');
    if (response.statusCode != 200) {
      throw response.body;
    }
    final decoded = json.decode(response.body) as Map<String, dynamic>;
    decoded.forEach((id, data) {
      exercises.add(
        Exercise(
          id,
          data['workoutId'],
          data['imageUrl'],
          data['title'],
          data['description'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> add(Exercise e) async {
    final response = await http.post(
      '$url.json',
      body: json.encode(
        {
          'id': e.id,
          'workoutId': e.workoutId,
          'imageUrl': e.imageUrl,
          'title': e.title,
          'description': e.description
        },
      ),
    );

    if (response.statusCode != 200) {
      throw response.body;
    }

    notifyListeners();
  }
}