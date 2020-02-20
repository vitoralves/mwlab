import 'package:flutter/material.dart';

import './Home.dart';
import './Workouts.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Menu de Opções',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    backgroundColor: Colors.black54,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://alexfeds.com/wp-content/uploads/2017/10/gym.jpg'),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
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
            leading: Icon(Icons.fitness_center),
            title: Text('Meus Treinos'),
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
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
          ),
        ],
      ),
    );
  }
}
