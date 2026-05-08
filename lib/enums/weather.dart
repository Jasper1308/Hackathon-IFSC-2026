enum Weather {
  quente,
  frio,
  neutro,
  ensolarado,
}

extension WeatherExtension on Weather {
  String get label {
    switch (this) {
      case Weather.quente:
        return "Quente";
      case Weather.frio:
        return "Frio";
      case Weather.neutro:
        return "Neutro";
      case Weather.ensolarado:
        return "Ensolarado";
    }
  }
}