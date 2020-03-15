import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String _userId;
  String _token;

  bool get logedIn {
    return _token != null;
  }

  String get token {
    return _token;
  }

  String get userId {
    return _userId;
  }

  Future<void> authenticate(
      String email, String password, String action) async {
    final url =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$action?key=AIzaSyBJvGIWl7YLRoHCtEjbjEaRyIeraqllRfs';

    final response = await http.post(url,
        body: json.encode({'email': email, 'password': password}));
    final responseBody = json.decode(response.body);

    if (responseBody['error'] != null) {
      throw responseBody['error']['message'];
    }

    _userId = responseBody['localId'];
    _token = responseBody['idToken'];
    notifyListeners();
  }

  Future<void> logout() async {
    _userId = null;
    _token = null;
  }
}
