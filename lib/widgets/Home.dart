import 'package:flutter/material.dart';

import './AppDrawer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ButtonBar(
                children: <Widget>[
                  OutlineButton(
                    child: Text('Seg'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                        style: BorderStyle.solid),
                    textColor: Theme.of(context).accentColor,
                    onPressed: () => print('clicou'),
                  ),
                  OutlineButton(
                    child: Text('Ter'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                        style: BorderStyle.solid),
                    textColor: Theme.of(context).accentColor,
                    onPressed: () => print('clicou'),
                  ),
                  OutlineButton(
                    child: Text('Qua'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                        style: BorderStyle.solid),
                    textColor: Theme.of(context).accentColor,
                    onPressed: () => print('clicou'),
                  ),
                  OutlineButton(
                    child: Text('Qui'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                        style: BorderStyle.solid),
                    textColor: Theme.of(context).accentColor,
                    onPressed: () => print('clicou'),
                  ),
                  OutlineButton(
                    child: Text('Sex'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                        style: BorderStyle.solid),
                    textColor: Theme.of(context).accentColor,
                    onPressed: () => print('clicou'),
                  ),
                  OutlineButton(
                    child: Text('Sáb'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                        style: BorderStyle.solid),
                    textColor: Theme.of(context).accentColor,
                    onPressed: () => print('clicou'),
                  ),
                  OutlineButton(
                    child: Text('Dom'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                        style: BorderStyle.solid),
                    textColor: Theme.of(context).accentColor,
                    onPressed: () => print('clicou'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  elevation: 5,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 200,
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
                                        color: Color.fromRGBO(37, 37, 95, 1),
                                        fontWeight: FontWeight.bold,
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
                                    'Supino',
                                    style: TextStyle(
                                      color: Color.fromRGBO(37, 37, 95, 1),
                                      fontSize: 25,
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
                            image: NetworkImage(
                                'https://www.feitodeiridium.com.br/wp-content/uploads/2016/09/treino-insano-peitoral-3.jpg'),
                            width: 130,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
    );
  }
}
