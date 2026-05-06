import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _userId;

  String? get userId => _userId;

  void setUser(String id) {
    _userId = id;
    notifyListeners();
  }
}