import 'package:flutter/material.dart';

import '../widgets/exercise_list.dart';
import './add_exercise_screen.dart';

class Exercises extends StatelessWidget {
  final String workoutId;
  final String workoutName;

  Exercises(this.workoutId, this.workoutName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AddExerciseScreen(workoutId))),
          ),
        ],
        title: Text(
          'Exercícios $workoutName',
          style: TextStyle(
            color: Theme.of(context).textTheme.title.color,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/bg4.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ExerciseList(workoutId, 1),
      ),
    );
  }
}
