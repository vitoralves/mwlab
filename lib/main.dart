import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth_provider.dart';
import './screens/login_screen.dart';
import './screens/home_screen.dart';

import './providers/workout_provider.dart';
import './providers/exercises_provider.dart';

import './helpers/CustomRoute.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, WorkoutProvider>(
          create: (_) => WorkoutProvider('', ''),
          update: (_, auth, workout) {
            return WorkoutProvider(auth.token, auth.userId);
          },
        ),
        ChangeNotifierProxyProvider<AuthProvider, ExercisesProvider>(
            create: (_) => ExercisesProvider(''),
            update: (_, auth, exercise) {
              return ExercisesProvider(auth.token);
            }),
      ],
      child: MaterialApp(
        title: 'My Workout',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Color.fromRGBO(29, 34, 37, 0.9),
            textTheme: TextTheme(
              headline6: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
          scaffoldBackgroundColor: Color.fromRGBO(29, 34, 37, 0.9),
          dialogBackgroundColor: Color.fromRGBO(29, 34, 37, 1),
          dialogTheme: DialogTheme(
              contentTextStyle: TextStyle(
            color: Colors.white,
          )),
          cardColor: Color.fromRGBO(60, 70, 72, 0.9),
          accentColor: Color.fromRGBO(0, 223, 100, 1),
          cursorColor: Color.fromRGBO(0, 223, 100, 1),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.white,
            ),
            bodyText2: TextStyle(
              color: Colors.white,
            ),
            subtitle1: TextStyle(
              color: Colors.white,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Color.fromRGBO(48, 56, 62, 0.9),
            filled: true,
            border: InputBorder.none,
            labelStyle: TextStyle(color: Color.fromRGBO(151, 152, 152, 1)),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Color.fromRGBO(0, 223, 100, 1),
            textTheme: ButtonTextTheme.primary,
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Color.fromRGBO(0, 223, 100, 1),
                ),
          ),
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CustomPageTransition(),
            TargetPlatform.iOS: CustomPageTransition()
          }),
        ),
        debugShowCheckedModeBanner: false,
        home: Consumer<AuthProvider>(
          builder: (context, auth, _) {
            if (auth.logedIn) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
