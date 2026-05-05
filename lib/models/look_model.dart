class Look {
  final String id;
  final String userId;
  final List<String> pecasIds;
  final String? nome;

  Look({
    required this.id,
    required this.userId,
    required this.pecasIds,
    this.nome,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'pecasIds': pecasIds,
      'nome': nome,
    };
  }

  factory Look.fromJson(String id, Map<String, dynamic> json) {
    return Look(
      id: id,
      userId: json['userId'],
      pecasIds: List<String>.from(json['pecasIds']),
      nome: json['nome'],
    );
  }
}