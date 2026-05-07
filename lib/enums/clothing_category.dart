enum ClothingCategory {
  masculino,
  feminino
}

extension ClothingCategoryExtension on ClothingCategory {
  String get label {
    switch (this) {
      case ClothingCategory.masculino:
        return "Masculino";
      case ClothingCategory.feminino:
        return "Feminino";

    }
  }
}