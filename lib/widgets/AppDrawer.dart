import 'package:flutter/material.dart';

import './Home.dart';
import './Workouts.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: Drawer(
          child: Container(
            color: Color.fromRGBO(29, 36, 41, 0.8),
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Home',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Home(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.fitness_center,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Meus Treinos',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Workouts(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Sair',
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
