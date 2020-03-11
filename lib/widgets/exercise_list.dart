import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/exercises_provider.dart';

class ExerciseList extends StatefulWidget {
  final String workoutId;

  ExerciseList(this.workoutId);

  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  bool _loading = false;

  Future<void> _remove(String id) async {
    setState(() {
      _loading = true;
    });

    await Provider.of<ExercisesProvider>(context, listen: false).delete(id);

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: CircularProgressIndicator())
        : FutureBuilder(
            future: Provider.of<ExercisesProvider>(context).get(workoutId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      elevation: 5,
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          child: Image(
                            image: NetworkImage(exercises[index].imageUrl),
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () => _remove(exercises[index].id),
                        ),
                        title: Text(
                          exercises[index].title,
                          style: TextStyle(
                            color: Color.fromRGBO(37, 37, 95, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          exercises[index].description,
                          style: TextStyle(
                            color: Color.fromRGBO(205, 205, 218, 1),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            });
    // Consumer<ExercisesProvider>(
    //   builder: (context, provider, _) {
    //     final exercises = provider.exercises;
    //     print(provider.url);
    //     print(exercises);
    //     if (exercises.isEmpty) {
    //       return Center(
    //           child: Text(
    //         'Nenhum exercício cadastrado.',
    //         style: TextStyle(
    //           fontSize: Theme.of(context).textTheme.title.fontSize,
    //           backgroundColor: Theme.of(context).backgroundColor,
    //         ),
    //       ));
    //     }
    //   },
    // );
  }
}
