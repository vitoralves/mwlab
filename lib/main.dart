import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widgets/Home.dart';

import './providers/WorkoutProvider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
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
          appBarTheme: AppBarTheme(
            color: Color.fromRGBO(29, 34, 37, 0.9),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromRGBO(29, 34, 37, 0.9),
          dialogBackgroundColor: Color.fromRGBO(29, 34, 37, 1),
          dialogTheme: DialogTheme(
              contentTextStyle: TextStyle(
            color: Colors.white,
          )),
          cardColor: Color.fromRGBO(60, 70, 72, 0.9),
          primaryColor: Colors.white,
          accentColor: Color.fromRGBO(0, 223, 100, 1),
          textTheme: TextTheme(
            body1: TextStyle(
              color: Colors.white,
            ),
            title: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
            subtitle: TextStyle(
              // color: Color.fromRGBO(109, 121, 125, 1),
              color: Color.fromRGBO(151, 152, 152, 1),
              fontSize: 15,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
