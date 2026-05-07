enum Cores {
  branco,
  preto,
  vermelho,
  azul,
  rosa,
  amarelo,
  verde,
  cinza,
}

extension CoresExtension on Cores {
  String get label {
    switch (this) {
      case Cores.branco:
        return "Branco";
      case Cores.preto:
        return "Preto";
      case Cores.vermelho:
        return "Vermelho";
      case Cores.azul:
        return "Azul";
      case Cores.rosa:
        return "Rosa";
      case Cores.amarelo:
        return "Amarelo";
      case Cores.verde:
        return "Verde";
      case Cores.cinza:
        return "Cinza";
    }
  }
}