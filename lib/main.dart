import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widgets/Home.dart';

import './providers/WorkoutProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<WorkoutProvider>(
          create: (_) => WorkoutProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'My Workout',
        theme: ThemeData(
          backgroundColor: Color.fromRGBO(242, 242, 242, 1),
          primaryColor: Colors.white,
          accentColor: Color.fromRGBO(101, 66, 182, 1),
          textTheme: TextTheme(
            title: TextStyle(
              color: Color.fromRGBO(37, 37, 95, 1),
              fontWeight: FontWeight.bold,
            ),
            subtitle: TextStyle(color: Color.fromRGBO(205, 205, 218, 1)),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
