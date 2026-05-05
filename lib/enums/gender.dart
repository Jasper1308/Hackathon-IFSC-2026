enum Gender {
  masculino,
  feminino,
  unissex,
}

extension GenderExtension on Gender {
  String get label {
    switch (this) {
      case Gender.masculino:
        return "Masculino";
      case Gender.feminino:
        return "Feminino";
      case Gender.unissex:
        return "Unissex";
    }
  }
}