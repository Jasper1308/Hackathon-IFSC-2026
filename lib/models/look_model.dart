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
      'user_id': userId,
      'pecas_ids': pecasIds,
      'nome': nome,
    };
  }

  factory Look.fromJson(
      String id,
      Map<String, dynamic> json,
      ) {
    return Look(
      id: id,
      userId: json['user_id'],
      pecasIds:
      List<String>.from(
        json['pecas_ids'],
      ),
      nome: json['nome'],
    );
  }
}