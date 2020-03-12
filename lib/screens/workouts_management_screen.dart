import 'package:flutter/material.dart';
import '../models/Workout.dart';
import 'package:provider/provider.dart';

import '../providers/workout_provider.dart';
import '../utils/util.dart';

class WorkoutsManagement extends StatefulWidget {
  @override
  _WorkoutsManagementState createState() => _WorkoutsManagementState();
}

class _WorkoutsManagementState extends State<WorkoutsManagement> {
  final _form = GlobalKey<FormState>();
  final _imageFocus = FocusNode();
  final _dropDownFocus = FocusNode();

  var _workout = Workout();

  int _dropdownValue;
  bool _dropdownValid = true;
  bool _loading = true;
  var _dropDownOptions = [
    {'id': 1, 'name': 'Segunda-Feira'},
    {'id': 2, 'name': 'Terça-Feira'},
    {'id': 3, 'name': 'Quarta-Feira'},
    {'id': 4, 'name': 'Quinta-Feira'},
    {'id': 5, 'name': 'Sexta-Feira'},
    {'id': 6, 'name': 'Sábado'},
    {'id': 7, 'name': 'Domingo'},
  ];
  bool _isInit = true;

  _showAlert(error) async {
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
  }

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
        if (_workout.id != null) {
          await Provider.of<WorkoutProvider>(context, listen: false)
              .update(_workout);
        } else {
          await Provider.of<WorkoutProvider>(context, listen: false)
              .add(_workout);
        }
        Navigator.of(context).pop();
      } catch (error) {
        await _showAlert(error);
      } finally {
        setState(() {
          _loading = false;
        });
      }
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _delete() async {
    Navigator.of(context).pop();
    setState(() {
      _loading = true;
    });
    try {
      await Provider.of<WorkoutProvider>(context, listen: false)
          .delete(_workout.id);
      Navigator.of(context).pop();
    } catch (error) {
      await _showAlert(error);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _showConfirmationModal() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Você têm certeza?'),
          content: Text('Essa ação não poderá ser desfeita, continuar?'),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancelar')),
            FlatButton(
              onPressed: _delete,
              child: Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final String id = ModalRoute.of(context).settings.arguments;
      if (id != null) {
        _workout =
            Provider.of<WorkoutProvider>(context, listen: false).getById(id);
        _dropdownValue = _workout.weekDay;
        setState(() {
          _loading = false;
        });
      } else {
        setState(() {
          _loading = false;
        });
      }
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final _util = Util();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: _workout.id != null
            ? <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: _showConfirmationModal,
                ),
              ]
            : [],
        title: Text(
          'Novo Treino',
          style: TextStyle(
            color: Theme.of(context).textTheme.title.color,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/bg2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
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
                        initialValue: _workout.name,
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
                        style: TextStyle(color: Colors.white),
                        decoration: _util.getDecoration(context, 'Nome'),
                        cursorColor: Theme.of(context).accentColor,
                      ),
                      TextFormField(
                        initialValue: _workout.imageUrl,
                        onSaved: (value) {
                          _workout.imageUrl = value;
                        },
                        textInputAction: TextInputAction.next,
                        focusNode: _imageFocus,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_dropDownFocus),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Insira uma imagem';
                          }
                          if (!value.startsWith('https://') &&
                              !value.startsWith('http://')) {
                            return 'Endereço inválido';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: _util.getDecoration(context, 'Imagem URL'),
                        cursorColor: Theme.of(context).accentColor,
                      ),
                      DropdownButtonHideUnderline(
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          color: Color.fromRGBO(48, 56, 62, 0.9),
                          height: 60,
                          child: DropdownButton(
                              focusNode: _dropDownFocus,
                              value: _dropdownValue,
                              icon: Icon(Icons.calendar_today),
                              isExpanded: true,
                              hint: Text(
                                'Dia da semana',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .color),
                              ),
                              iconEnabledColor: Theme.of(context).accentColor,
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.subtitle.color,
                              ),
                              items: _dropDownOptions.map((e) {
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
                        height: 50,
                        child: RaisedButton(
                          child: Text('SALVAR'),
                          color: Theme.of(context).accentColor,
                          textColor: Colors.white,
                          onPressed: _save,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
