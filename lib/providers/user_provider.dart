import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  final UserService service;

  UserProvider(this.service);

  UserModel? _user;

  UserModel? get user => _user;

  bool get hasUser => _user != null;

  Future<void> loadUser(String id) async {
    _user = await service.getUser(id);

    notifyListeners();
  }

  Future<void> createUser(UserModel user) async {
    await service.createUser(user);

    _user = user;

    notifyListeners();
  }

  void clearUser() {
    _user = null;

    notifyListeners();
  }
}