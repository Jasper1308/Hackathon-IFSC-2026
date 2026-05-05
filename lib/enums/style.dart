enum Style {
  casual,
  formal,
  esportivo,
}

extension StyleExtension on Style {
  String get label {
    switch (this) {
      case Style.casual:
        return "Casual";
      case Style.formal:
        return "Formal";
      case Style.esportivo:
        return "Esportivo";
    }
  }
}