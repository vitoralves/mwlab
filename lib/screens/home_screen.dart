import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/workout_provider.dart';
import '../widgets/today_workout.dart';

import '../widgets/app_drawer.dart';
import '../utils/Util.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final util = Util();
  int _weekDay = DateTime.now().weekday;

  List<FlatButton> _getButtonBar(context) {
    List<FlatButton> list = [];
    for (int i = 1; i < 8; i++) {
      list.add(FlatButton(
        child: Text(util.convertWeekDay(i).toString().substring(0, 3)),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            // color: Theme.of(context).accentColor,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        // textColor: _weekDay == i
        //     ? Theme.of(context).primaryColor
        //     : Theme.of(context).accentColor,
        // color:
        //     _weekDay == i ? Theme.of(context).accentColor : Colors.transparent,
        onPressed: () => _updateWeekDay(i),
      ));
    }
    return list;
  }

  void _updateWeekDay(int value) {
    setState(() {
      _weekDay = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Home',
          // style: TextStyle(
          //   color: Theme.of(context).textTheme.title.color,
          // ),
        ),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<WorkoutProvider>(context, listen: false).get(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: _mediaQuery.size.height,
              width: _mediaQuery.size.width,
              child: Center(
                child: CircularProgressIndicator(),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/bg3.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else if (snapshot.error == true) {
            return Center(
              child: Text(
                  'Não foi possível buscar os dados, por favor tente novamente.'),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/bg3.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: <Widget>[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          // color: Theme.of(context).backgroundColor,
                          child: ButtonBar(
                            children: _getButtonBar(context),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          TodayWorkout(_weekDay),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          }
          return null;
        },
      ),
    );
  }
}
