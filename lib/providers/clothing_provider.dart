import 'package:flutter/material.dart';
import '../models/clothing_model.dart';

class ClothingProvider with ChangeNotifier {
  final ClothingService service;

  ClothingProvider(this.service);

  List<Clothing> _myClothes = [];
  List<Clothing> _communityClothes = [];

  List<Clothing> get myClothes => _myClothes;
  List<Clothing> get communityClothes => _communityClothes;

  Future<void> loadMyClothes(String userId) async {
    _myClothes = await service.getUserClothes(userId);
    notifyListeners();
  }

  Future<void> loadCommunityClothes(String userId) async {
    _communityClothes = await service.getCommunityClothes(userId);
    notifyListeners();
  }

  Future<void> addClothing(Clothing item) async {
    await service.addClothing(item);
    _myClothes.add(item);
    notifyListeners();
  }
}