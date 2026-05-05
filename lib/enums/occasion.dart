enum Occasion {
  casual,
  trabalho,
  festa,
}

extension OccasionExtension on Occasion {
  String get label {
    switch (this) {
      case Occasion.casual:
        return "Casual";
      case Occasion.trabalho:
        return "Trabalho";
      case Occasion.festa:
        return "Festa";
    }
  }
}