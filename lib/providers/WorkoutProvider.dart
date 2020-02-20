import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/Workout.dart';

class WorkoutProvider with ChangeNotifier {
  final url = 'https://mwlabdb.firebaseio.com/workout.json';

  Future<void> add(Workout w) async {
    final response = await http.post(url,
        body: json.encode({
          'id': w.id,
          'name': w.name,
          'imageUrl': w.imageUrl,
          'weekDay': w.weekDay
        }));
  }
}
