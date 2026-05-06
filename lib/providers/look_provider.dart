import 'dart:math';
import '../models/clothing_model.dart';
import 'package:flutter/material.dart';

class LookProvider with ChangeNotifier {
  Map<String, Clothing>? _currentLook;

  Map<String, Clothing>? get currentLook => _currentLook;

  void generateLook(List<Clothing> clothes) {
    final superiores =
    clothes.where((c) => c.categoria.name == 'superior').toList();
    final inferiores =
    clothes.where((c) => c.categoria.name == 'inferior').toList();
    final calcados =
    clothes.where((c) => c.categoria.name == 'calcado').toList();

    if (superiores.isEmpty || inferiores.isEmpty || calcados.isEmpty) return;

    final random = Random();

    _currentLook = {
      'superior': superiores[random.nextInt(superiores.length)],
      'inferior': inferiores[random.nextInt(inferiores.length)],
      'calcado': calcados[random.nextInt(calcados.length)],
    };

    notifyListeners();
  }
}