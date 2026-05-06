import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider with ChangeNotifier {
  final supabase = Supabase.instance.client;

  User? _user;

  User? get user => _user;

  String? get userId => _user?.id;

  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _user = supabase.auth.currentUser;

    supabase.auth.onAuthStateChange.listen((data) {
      _user = data.session?.user;
      notifyListeners();
    });
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    _user = supabase.auth.currentUser;

    notifyListeners();
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    await supabase.auth.signUp(
      email: email,
      password: password,
    );

    _user = supabase.auth.currentUser;

    notifyListeners();
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();

    _user = null;

    notifyListeners();
  }
}