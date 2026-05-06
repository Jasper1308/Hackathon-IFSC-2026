import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_model.dart';

class UserService {
  final supabase = Supabase.instance.client;

  Future<void> createUser(UserModel user) async {
    await supabase.from('users').insert(
      user.toJson(),
    );
  }

  Future<UserModel?> getUser(String id) async {
    final response = await supabase
        .from('users')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) return null;

    return UserModel.fromJson(
      response['id'],
      response,
    );
  }
}