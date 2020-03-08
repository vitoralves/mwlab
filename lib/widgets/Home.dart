import 'package:flutter/material.dart';
import 'package:my_workout/widgets/TodayWorkout.dart';

import './AppDrawer.dart';
import '../utils/Util.dart';

class Home extends StatelessWidget {
  final util = Util();
  // final int _weekDay = DateTime.now().weekday;
  final int _weekDay = 1;

  List<FlatButton> _getButtonBar(context) {
    List<FlatButton> list = [];
    for (int i = 1; i < 8; i++) {
      list.add(FlatButton(
        child: Text(util.convertWeekDay(i).toString().substring(0, 3)),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).accentColor,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        textColor: _weekDay == i
            ? Theme.of(context).primaryColor
            : Theme.of(context).accentColor,
        color:
            _weekDay == i ? Theme.of(context).accentColor : Colors.transparent,
        onPressed: () => print('clicou'),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: Stack(
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
                    color: Theme.of(context).backgroundColor,
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
                    SizedBox(
                      height: 20,
                    ),
                    Card(
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
                            image: NetworkImage(
                                'https://i.pinimg.com/originals/79/96/14/799614f500c5e53a59e605d2d85985d3.jpg'),
                          ),
                        ),
                        title: Text(
                          'Supino inclinado com hateres + crucifixo inclinado com halteres',
                          style: TextStyle(
                            color: Color.fromRGBO(37, 37, 95, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '3 séries de 8 repetições cada',
                          style: TextStyle(
                            color: Color.fromRGBO(205, 205, 218, 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
