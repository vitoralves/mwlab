import 'package:flutter/material.dart';

import '../utils/util.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final _form = GlobalKey<FormState>();
    final _passwordFocus = FocusNode();
    final _util = Util();
    final _user = {'email': '', 'password': ''};
    bool _loading = false;

    _save() {
      try {
        setState(() {
          _loading = true;
        });
        bool valid = _form.currentState.validate();

        if (valid) {
          _form.currentState.save();
        }
      } catch (error) {
        print(error);
      } finally {
        setState(() {
          _loading = false;
        });
      }
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/login_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: _loading
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _form,
                  child: ListView(
                    children: <Widget>[
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
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _user['password'] = value;
                        },
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return 'A senha deve conter mais de 3 caracteres';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) => _save(),
                        textInputAction: TextInputAction.send,
                        focusNode: _passwordFocus,
                        decoration: _util.getDecoration(context, 'Senha'),
                        cursorColor: Theme.of(context).accentColor,
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
                            child: Text('ENTRAR'),
                            onPressed: _save),
                      ),
                      FlatButton(onPressed: null, child: Text('Criar conta')),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
