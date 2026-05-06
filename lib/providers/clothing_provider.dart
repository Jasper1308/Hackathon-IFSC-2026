import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/clothing_model.dart';
import '../services/clothing_service.dart';

class ClothingProvider with ChangeNotifier {
  final ClothingService service;

  ClothingProvider(this.service);

  List<Clothing> _myClothes = [];
  List<Clothing> _communityClothes = [];

  List<Clothing> get myClothes => _myClothes;
  List<Clothing> get communityClothes => _communityClothes;

  final user = Supabase.instance.client.auth.currentUser;

  Future<void> loadMyClothes() async {
    if (user == null) return;

    _myClothes = await service.getUserClothes(user!.id);

    notifyListeners();
  }

  Future<void> loadCommunityClothes() async {
    if (user == null) return;

    _communityClothes =
    await service.getCommunityClothes(user!.id);

    notifyListeners();
  }

  Future<void> addClothing(Clothing item) async {
    await service.addClothing(item);

    _myClothes.add(item);

    notifyListeners();
  }
}