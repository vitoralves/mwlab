import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/exercise_list.dart';

import '../providers/exercises_provider.dart';
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
            image: ExactAssetImage('assets/images/bg2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder(
          future: Provider.of<ExercisesProvider>(context).get(workoutId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.error == true) {
              return Center(
                child: Text(
                    'Não foi possível buscar dados, por favor tente novamente.'),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return ExerciseList();
            } else {
              return Center(
                child: Text(
                    'Não foi possível buscar dados, por favor tente novamente.'),
              );
            }
          },
        ),
      ),
    );
  }
}
