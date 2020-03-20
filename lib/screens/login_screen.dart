import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utils/util.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  final _util = Util();
  final _user = {'email': '', 'password': '', 'confirmPassword': ''};
  bool _loading = false;
  bool _login = true;

  _save() async {
    try {
      setState(() {
        _loading = true;
      });
      bool valid = _form.currentState.validate();

      if (valid) {
        _form.currentState.save();
        if (_login) {
          await Provider.of<AuthProvider>(context, listen: false).authenticate(
              _user['email'], _user['password'], 'verifyPassword');
        } else {
          if (_user['password'] != _user['confirmPassword']) {
            _showErrorDialog('As senhas devem ser iguais.');
          } else {
            await Provider.of<AuthProvider>(context, listen: false)
                .authenticate(
                    _user['email'], _user['password'], 'signupNewUser');
            setState(() {
              _login = true;
            });
          }
        }
      }
    } catch (error) {
      var errorMessage = 'Autenticação falhou';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'Email já cadastrado';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Email inválido';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'Senha muito fraca';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Email não encontrado';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Senha inválida';
      }
      _showErrorDialog(errorMessage);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ocorreu uma falha'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  _switchMode() {
    setState(() {
      _login = !_login;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/login_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _form,
                  child: ListView(
                    children: <Widget>[
                      if (_login)
                        SizedBox(
                          height: _mediaQuery.size.height * 0.6,
                          child: Center(
                            child: Text(
                              'MyWorkout',
                              style: TextStyle(fontSize: 70),
                            ),
                          ),
                        ),
                      TextFormField(
                        initialValue: '',
                        onSaved: (value) {
                          _user['email'] = value;
                        },
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return 'Usuário deve ter mais de 3 caracteres';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_passwordFocus),
                        textInputAction: TextInputAction.next,
                        decoration: _util.getDecoration(context, 'Email'),
                        cursorColor: Theme.of(context).accentColor,
                        style: TextStyle(color: Colors.white),
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _user['password'] = value;
                        },
                        validator: (value) {
                          if (value.isEmpty || value.length < 6) {
                            return 'A senha deve conter no mínimo 6 caracteres';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          if (_login) {
                            _save();
                          } else {
                            FocusScope.of(context)
                                .requestFocus(_confirmPasswordFocus);
                          }
                        },
                        textInputAction: TextInputAction.send,
                        focusNode: _passwordFocus,
                        decoration: _util.getDecoration(context, 'Senha'),
                        cursorColor: Theme.of(context).accentColor,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        obscureText: true,
                      ),
                      if (!_login)
                        TextFormField(
                          onSaved: (value) {
                            _user['confirmPassword'] = value;
                          },
                          validator: (value) {
                            if (value.isEmpty || value.length < 6) {
                              return 'A senha deve conter no mínimo 6 caracteres';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) => _save(),
                          textInputAction: TextInputAction.send,
                          focusNode: _confirmPasswordFocus,
                          decoration:
                              _util.getDecoration(context, 'Confirmar Senha'),
                          cursorColor: Theme.of(context).accentColor,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          obscureText: true,
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Colors.white,
                          child: Text(_login ? 'ENTRAR' : 'CADASTRAR'),
                          onPressed: _save,
                        ),
                      ),
                      FlatButton(
                        onPressed: _switchMode,
                        child: Text(
                          _login ? 'Criar conta' : 'Entrar',
                          style: TextStyle(
                            color: Colors.blue,
                            backgroundColor: Theme.of(context).backgroundColor,
                          ),
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
