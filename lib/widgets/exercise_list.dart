import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/exercises_provider.dart';

class ExerciseList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExercisesProvider>(builder: (context, provider, _) {
      final exercises = provider.exercises;
      if (exercises.isEmpty) {
        return Center(
            child: Text(
          'Nenhum exercício cadastrado.',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.title.fontSize,
            backgroundColor: Theme.of(context).backgroundColor,
          ),
        ));
      }
      return ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(exercises[index].title),
              subtitle: Text(exercises[index].description),
            );
          },
          separatorBuilder: (_, index) => Divider(),
          itemCount: exercises.length);
    });
  }
}
