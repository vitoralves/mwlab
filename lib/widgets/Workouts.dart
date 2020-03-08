import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/WorkoutProvider.dart';

import './AppDrawer.dart';
import './WorkoutsManagement.dart';
import '../widgets/WorkoutCard.dart';

class Workouts extends StatelessWidget {
  Future<void> _loadWorkouts(BuildContext context) async {
    await Provider.of<WorkoutProvider>(context, listen: false).getWorkouts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Treinos',
          style: TextStyle(color: Theme.of(context).textTheme.title.color),
        ),
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WorkoutsManagement(),
                  ),
                );
              }),
        ],
      ),
      body: FutureBuilder(
        future: _loadWorkouts(context),
        builder: (context, snapshot) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage('assets/images/bg1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: snapshot.connectionState == ConnectionState.done
                    ? Consumer<WorkoutProvider>(
                        builder: (context, provider, _) => ListView.builder(
                          itemCount: provider.workouts.length,
                          itemBuilder: (_, i) => WorkoutCard(
                            provider.workouts[i].id,
                            provider.workouts[i].imageUrl,
                            provider.workouts[i].name,
                            provider.workouts[i].weekDay.toString(),
                          ),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
