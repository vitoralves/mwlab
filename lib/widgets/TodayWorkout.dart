import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/WorkoutProvider.dart';

class TodayWorkout extends StatelessWidget {
  final int weekDay;

  TodayWorkout(this.weekDay);

  @override
  Widget build(BuildContext context) {
    final _query = MediaQuery.of(context);

    return Consumer<WorkoutProvider>(builder: (context, provider, _) {
      var index = provider.workouts.indexWhere((w) => w.weekDay == weekDay);
      if (index != -1) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          elevation: 5,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: _query.size.width * 0.6,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 30,
                              right: 30,
                              top: 30,
                              bottom: 20,
                            ),
                            child: Text(
                              'Treino de hoje',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 40,
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 30,
                            right: 30,
                            bottom: 30,
                          ),
                          child: Text(
                            provider.workouts[index].name,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.subtitle.color,
                              fontSize: 30,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: Image(
                    image: NetworkImage(provider.workouts[index].imageUrl),
                    width: 130,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return Center(
        child: Text('Nenhum treinamento para o dia de hoje.'),
      );
    });
  }
}
