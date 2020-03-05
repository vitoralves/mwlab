import 'package:flutter/material.dart';
import '../models/Workout.dart';
import 'package:provider/provider.dart';

import '../providers/WorkoutProvider.dart';

class WorkoutsManagement extends StatefulWidget {
  @override
  _WorkoutsManagementState createState() => _WorkoutsManagementState();
}

class _WorkoutsManagementState extends State<WorkoutsManagement> {
  final _form = GlobalKey<FormState>();
  final _imageFocus = FocusNode();
  final _weekDayFocus = FocusNode();

  var _workout = Workout('1', 'name', '.jpg', 2);

  int _dropdownValue;
  bool _dropdownValid = true;
  bool _loading = false;

  Future<void> _save() async {
    setState(() {
      _loading = true;
    });
    setState(() {
      if (_dropdownValue == null) {
        _dropdownValid = false;
      } else {
        _workout.weekDay = _dropdownValue;
        _dropdownValid = true;
      }
    });
    bool isValid = _form.currentState.validate();
    if (isValid) {
      _form.currentState.save();
      try {
        await Provider.of<WorkoutProvider>(context, listen: false)
            .add(_workout);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('Falha ao salvar'),
                content: Text(error.toString()),
                actions: <Widget>[
                  FlatButton(
                      child: Text('Fechar'),
                      onPressed: () => Navigator.of(context).pop()),
                ],
              );
            });
      } finally {
        setState(() {
          _loading = false;
        });
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Treino'),
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: _loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: <Widget>[
                      TextFormField(
                        onSaved: (value) {
                          _workout.name = value;
                        },
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_imageFocus),
                        validator: (value) {
                          if (value.isEmpty || value.length < 3) {
                            return 'O nome deve ter no mínimo 3 caracteres';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          labelStyle: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                          border: OutlineInputBorder(),
                          hintStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                        cursorColor: Theme.of(context).accentColor,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _workout.imageUrl = value;
                        },
                        textInputAction: TextInputAction.next,
                        focusNode: _imageFocus,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_weekDayFocus),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Insira uma imagem';
                          }
                          if (!value.endsWith('.jpg') &&
                              !value.endsWith('.png')) {
                            return 'A imagem deve ser no formato JPG ou PNG';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Imagem URL',
                          labelStyle: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                          border: OutlineInputBorder(),
                          hintStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                        cursorColor: Theme.of(context).accentColor,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonHideUnderline(
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: _dropdownValid
                                      ? Colors.black38
                                      : Color.fromRGBO(211, 46, 47, 1),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                          ),
                          child: DropdownButton(
                              value: _dropdownValue,
                              icon: Icon(Icons.calendar_today),
                              isExpanded: true,
                              hint: Text(
                                'Dia da semana',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                              iconEnabledColor: Theme.of(context).accentColor,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                              items: [
                                {'id': 0, 'name': 'Domingo'},
                                {'id': 1, 'name': 'Segunda-feira'},
                                {'id': 2, 'name': 'Terça-feira'},
                                {'id': 3, 'name': 'Quarta-Feira'},
                                {'id': 4, 'name': 'Quinta-Feira'},
                                {'id': 5, 'name': 'Sexta'},
                                {'id': 6, 'name': 'Sábado'},
                              ].map((e) {
                                return DropdownMenuItem(
                                  child: Text(e['name']),
                                  value: e['id'],
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _dropdownValue = value;
                                });
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _dropdownValid ? '' : 'Selecione um dia da semana',
                          style: TextStyle(
                              color: Color.fromRGBO(211, 46, 47, 1),
                              fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      RaisedButton(
                        child: Text('SALVAR'),
                        color: Theme.of(context).accentColor,
                        textColor: Colors.white,
                        onPressed: _save,
                      ),
                    ],
                  ),
          )),
    );
  }
}
