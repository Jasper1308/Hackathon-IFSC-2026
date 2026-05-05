enum Color {
  branco,
  preto,
  vermelho,
  azul,
  rosa,
  amarelo,
  verde,
  cinza,
}

extension ColorExtension on Color {
  String get label {
    switch (this) {
      case Color.branco:
        return "Branco";
      case Color.preto:
        return "Preto";
      case Color.vermelho:
        return "Vermelho";
      case Color.azul:
        return "Azul";
      case Color.rosa:
        return "Rosa";
      case Color.amarelo:
        return "Amarelo";
      case Color.verde:
        return "Verde";
      case Color.cinza:
        return "Cinza";
    }
  }
}