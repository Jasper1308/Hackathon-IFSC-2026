import 'dart:io';

import 'package:flutter/material.dart';

import '../enums/clothing_category.dart';
import '../enums/clothing_type.dart';
import '../enums/color.dart';
import '../enums/occasion.dart';
import '../enums/style.dart';
import '../enums/weather.dart';
import '../models/clothing_model.dart';
import '../services/clothing_service.dart';

class ClothingProvider with ChangeNotifier {
  final ClothingService service;

  ClothingProvider(this.service);

  List<Clothing> _myClothes = [];
  List<Clothing> _communityClothes = [];

  bool _isLoading = false;
  String? _lastError;

  List<Clothing> get myClothes => _myClothes;

  List<Clothing> get communityClothes =>
      _communityClothes;

  bool get isLoading => _isLoading;
  String? get lastError => _lastError;

  void loadDemoData({required String userId}) {
    _lastError = null;
    _isLoading = false;

    _myClothes = _demoClothes(userId: userId);
    _communityClothes = _demoClothes(userId: 'community-user')
        .map((c) => c.copyWith(disponivel: true))
        .toList();

    notifyListeners();
  }

  List<Clothing> _demoClothes({required String userId}) {
    return [
      Clothing(
        id: 'demo-1-$userId',
        userId: userId,
        nome: 'Camiseta Básica',
        categoria: ClothingCategory.superior,
        tipo: ClothingType.camiseta,
        cor: Cores.branco,
        estilo: Style.casual,
        clima: const [Weather.ensolarado, Weather.nublado],
        ocasiao: const [Occasion.casual],
        disponivel: true,
        imagemUrl: 'https://picsum.photos/seed/looklink1/900/900',
      ),
      Clothing(
        id: 'demo-2-$userId',
        userId: userId,
        nome: 'Calça Jeans',
        categoria: ClothingCategory.inferior,
        tipo: ClothingType.calca,
        cor: Cores.azul,
        estilo: Style.casual,
        clima: const [Weather.nublado, Weather.chuvoso],
        ocasiao: const [Occasion.casual, Occasion.trabalho],
        disponivel: false,
        imagemUrl: 'https://picsum.photos/seed/looklink2/900/900',
      ),
      Clothing(
        id: 'demo-3-$userId',
        userId: userId,
        nome: 'Tênis Clean',
        categoria: ClothingCategory.calcado,
        tipo: ClothingType.tenis,
        cor: Cores.preto,
        estilo: Style.casual,
        clima: const [Weather.ensolarado, Weather.nublado],
        ocasiao: const [Occasion.casual],
        disponivel: true,
        imagemUrl: 'https://picsum.photos/seed/looklink3/900/900',
      ),
    ];
  }

  Future<void> loadMyClothes(
      String userId,
      ) async {
    _isLoading = true;
    _lastError = null;

    notifyListeners();

    try {
      _myClothes =
          await service.getUserClothes(userId);
    } catch (e) {
      _lastError = e.toString();
      _myClothes = [];
    }

    _isLoading = false;

    notifyListeners();
  }

  Future<void> loadCommunityClothes(
      String userId,
      ) async {
    _isLoading = true;
    _lastError = null;
    notifyListeners();

    try {
      _communityClothes =
          await service.getCommunityClothes(
        userId,
      );
    } catch (e) {
      _lastError = e.toString();
      _communityClothes = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addClothing({
    required Clothing clothing,
    required File imageFile,
  }) async {
    _isLoading = true;
    _lastError = null;

    notifyListeners();

    try {
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
    } catch (e) {
      _lastError = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }

  }
}