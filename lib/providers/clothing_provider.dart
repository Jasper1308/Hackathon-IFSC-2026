import 'dart:io';

import 'package:flutter/material.dart';

import '../models/clothing_model.dart';
import '../services/clothing_service.dart';

class ClothingProvider with ChangeNotifier {
  final ClothingService service;

  ClothingProvider(this.service);

  List<Clothing> _myClothes = [];
  List<Clothing> _communityClothes = [];

  bool _isLoading = false;

  List<Clothing> get myClothes => _myClothes;

  List<Clothing> get communityClothes =>
      _communityClothes;

  bool get isLoading => _isLoading;

  Future<void> loadMyClothes(
      String userId,
      ) async {
    _isLoading = true;

    notifyListeners();

    _myClothes =
    await service.getUserClothes(userId);

    _isLoading = false;

    notifyListeners();
  }

  Future<void> loadCommunityClothes(
      String userId,
      ) async {
    _communityClothes =
    await service.getCommunityClothes(
      userId,
    );

    notifyListeners();
  }

  Future<void> addClothing({
    required Clothing clothing,
    required File imageFile,
  }) async {
    _isLoading = true;

    notifyListeners();

    final imageUrl =
    await service.uploadImage(imageFile);

    final updatedClothing =
    clothing.copyWith(
      imagemUrl: imageUrl,
    );

    await service.addClothing(
      updatedClothing,
    );

    _myClothes.add(updatedClothing);

    _isLoading = false;

    notifyListeners();
  }
}