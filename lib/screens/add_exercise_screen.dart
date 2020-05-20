import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/exercises_provider.dart';
import '../models/exercise.dart';

import '../utils/util.dart';

class AddExerciseScreen extends StatefulWidget {
  final String workoutId;

  AddExerciseScreen(this.workoutId);

  @override
  _AddExerciseScreenState createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  bool _loading = false;

  Exercise _exercise = Exercise();
  final _form = GlobalKey<FormState>();
  final _imageFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  Future<void> _save(context) async {
    setState(() {
      _loading = true;
    });
    bool isValid = _form.currentState.validate();
    if (isValid) {
      _form.currentState.save();
      try {
        _exercise.workoutId = widget.workoutId;
        await Provider.of<ExercisesProvider>(context, listen: false)
            .add(_exercise);
        Navigator.of(context).pop();
      } catch (error) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content:
                Text('Não foi possível salvar exercício, tente novamente')));
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

  @override
  Widget build(BuildContext context) {
    final _util = Util();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Novo Exercício',
          // style: TextStyle(
          //   color: Theme.of(context).textTheme.title.color,
          // ),
        ),
        elevation: 0,
        // backgroundColor: Theme.of(context).backgroundColor,
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
                        // style: TextStyle(color: Colors.white),
                        autofocus: true,
                        // decoration: _util.getDecoration(context, 'Nome'),
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          _exercise.title = value;
                        },
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_imageFocus),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe o nome do exercício';
                          } else if (value.length < 4) {
                            return 'Nome do exercício deve ter no mínimo 3 caracteres';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        // style: TextStyle(color: Colors.white),
                        focusNode: _imageFocus,
                        // decoration: _util.getDecoration(context, 'Imagem URL'),
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          _exercise.imageUrl = value;
                        },
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(_descriptionFocus),
                        validator: (value) {
                          if (value.isEmpty) {
                            if (!value.startsWith('https://') ||
                                !value.startsWith('http://')) {
                              return 'Imagem inválida';
                            }
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        // style: TextStyle(color: Colors.white),
                        focusNode: _descriptionFocus,
                        // decoration: _util.getDecoration(context, 'Descrição'),
                        onSaved: (value) {
                          _exercise.description = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe uma descrição';
                          }
                          return null;
                        },
                        maxLines: 5,
                        maxLength: 200,
                        onFieldSubmitted: (_) {
                          _save(context);
                        },
                        textInputAction: TextInputAction.send,
                      ),
                      SizedBox(
                        height: 50,
                        child: RaisedButton(
                          child: Text('SALVAR'),
                          // color: Theme.of(context).accentColor,
                          // textColor: Colors.white,
                          onPressed: () => _save(context),
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
