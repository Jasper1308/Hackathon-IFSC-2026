enum ClothingType {
  camiseta,
  camisa,
  calca,
  short,
  jaqueta,
  tenis,
  sapato,
}

extension ClothingTypeExtension on ClothingType {
  String get label {
    switch (this) {
      case ClothingType.camiseta:
        return "Camiseta";
      case ClothingType.camisa:
        return "Camisa";
      case ClothingType.calca:
        return "Calça";
      case ClothingType.short:
        return "Short";
      case ClothingType.jaqueta:
        return "Jaqueta";
      case ClothingType.tenis:
        return "Tênis";
      case ClothingType.sapato:
        return "Sapato";
    }
  }
}