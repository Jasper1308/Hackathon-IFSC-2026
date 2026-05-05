enum ClothingCategory {
  superior,
  inferior,
  calcado,
  acessorio,
}

extension ClothingCategoryExtension on ClothingCategory {
  String get label {
    switch (this) {
      case ClothingCategory.superior:
        return "Superior";
      case ClothingCategory.inferior:
        return "Inferior";
      case ClothingCategory.calcado:
        return "Calçado";
      case ClothingCategory.acessorio:
        return "Acessório";
    }
  }
}