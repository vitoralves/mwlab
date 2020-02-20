import 'package:flutter/material.dart';

import './AppDrawer.dart';
import './WorkoutsManagement.dart';

class Workouts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
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
      body: Text('Olá'),
    );
  }
}
