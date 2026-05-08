// lib/providers/look_provider.dart

import 'dart:math';

import 'package:flutter/material.dart';

import '../enums/occasion.dart';
import '../enums/weather.dart';
import '../models/clothing_model.dart';

class LookProvider with ChangeNotifier {
  Map<String, Clothing>? _currentLook;

  bool _isGenerating = false;
  String? _lastError;

  Map<String, Clothing>? get currentLook =>
      _currentLook;

  bool get isGenerating =>
      _isGenerating;

  String? get lastError => _lastError;

  Future<void> generateLook({
    required List<Clothing> clothes,
    required Weather clima,
    required Occasion ocasiao,
    Clothing? basePiece,
  }) async {
    _isGenerating = true;
    _lastError = null;

    notifyListeners();

    try {
      // Pequeno delay para permitir frame de loading antes do cálculo.
      await Future<void>.delayed(const Duration(milliseconds: 250));

      final superiores = clothes.where((c) {
        return c.categoria.name == 'superior' &&
            c.clima.contains(clima) &&
            c.ocasiao.contains(ocasiao);
      }).toList();

      final inferiores = clothes.where((c) {
        return c.categoria.name == 'inferior' &&
            c.clima.contains(clima) &&
            c.ocasiao.contains(ocasiao);
      }).toList();

      final calcados = clothes.where((c) {
        return c.categoria.name == 'calcado' &&
            c.clima.contains(clima) &&
            c.ocasiao.contains(ocasiao);
      }).toList();

      if (superiores.isEmpty || inferiores.isEmpty || calcados.isEmpty) {
        _currentLook = null;
        return;
      }

      int bestScore = -999;
      Map<String, Clothing>? bestLook;

      for (final superior in superiores) {
        for (final inferior in inferiores) {
          for (final calcado in calcados) {
            final ids = [superior.id, inferior.id, calcado.id];

            if (ids.toSet().length != 3) continue;

            if (basePiece != null && !ids.contains(basePiece.id)) {
              continue;
            }

            int score = 0;
            score += _styleScore(superior, inferior, calcado);
            score += _colorScore(superior, inferior, calcado);
            score += _occasionScore(superior, inferior, calcado, ocasiao);
            score += _weatherScore(superior, inferior, calcado, clima);

            if (basePiece != null &&
                (superior.estilo == basePiece.estilo ||
                    inferior.estilo == basePiece.estilo ||
                    calcado.estilo == basePiece.estilo)) {
              score += 6;
            }

            score += Random().nextInt(4);

            if (score > bestScore) {
              bestScore = score;
              bestLook = {
                'superior': superior,
                'inferior': inferior,
                'calcado': calcado,
              };
            }
          }
        }
      }

      _currentLook = bestLook;
    } catch (e) {
      _lastError = e.toString();
      _currentLook = null;
    } finally {
      _isGenerating = false;
      notifyListeners();
    }
  }

  int _styleScore(
      Clothing superior,
      Clothing inferior,
      Clothing calcado,
      ) {
    int score = 0;

    if (superior.estilo ==
        inferior.estilo) {
      score += 3;
    }

    if (inferior.estilo ==
        calcado.estilo) {
      score += 3;
    }

    if (superior.estilo ==
        calcado.estilo) {
      score += 3;
    }

    return score;
  }

  int _occasionScore(
      Clothing superior,
      Clothing inferior,
      Clothing calcado,
      Occasion occasion,
      ) {
    int score = 0;

    if (superior.ocasiao.contains(
      occasion,
    )) {
      score += 2;
    }

    if (inferior.ocasiao.contains(
      occasion,
    )) {
      score += 2;
    }

    if (calcado.ocasiao.contains(
      occasion,
    )) {
      score += 2;
    }

    return score;
  }

  int _weatherScore(
      Clothing superior,
      Clothing inferior,
      Clothing calcado,
      Weather weather,
      ) {
    int score = 0;

    if (superior.clima.contains(
      weather,
    )) {
      score += 2;
    }

    if (inferior.clima.contains(
      weather,
    )) {
      score += 2;
    }

    if (calcado.clima.contains(
      weather,
    )) {
      score += 2;
    }

    return score;
  }

  int _colorScore(
      Clothing superior,
      Clothing inferior,
      Clothing calcado,
      ) {
    int score = 0;

    final colors = [
      superior.cor.name,
      inferior.cor.name,
      calcado.cor.name,
    ];

    if (colors.contains(
      'preto',
    )) {
      score += 2;
    }

    if (colors.contains(
      'branco',
    )) {
      score += 2;
    }

    if (_matches(
      superior.cor.name,
      inferior.cor.name,
    )) {
      score += 3;
    }

    if (_matches(
      inferior.cor.name,
      calcado.cor.name,
    )) {
      score += 3;
    }

    if (_matches(
      superior.cor.name,
      calcado.cor.name,
    )) {
      score += 3;
    }

    return score;
  }

  bool _matches(
      String a,
      String b,
      ) {
    if (a == b) return true;

    final combinations = {
      'preto': [
        'branco',
        'cinza',
        'azul',
      ],
      'branco': [
        'preto',
        'azul',
        'verde',
      ],
      'azul': [
        'branco',
        'preto',
      ],
      'verde': [
        'preto',
        'branco',
      ],
      'vermelho': [
        'preto',
        'branco',
      ],
    };

    return combinations[a]
        ?.contains(b) ??
        false;
  }
}