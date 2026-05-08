import '../enums/clothing_category.dart';
import '../enums/clothing_type.dart';
import '../enums/color.dart';
import '../enums/style.dart';
import '../enums/occasion.dart';
import '../enums/weather.dart';

class Clothing {
  final String id;
  final String userId;
  final String nome;
  final ClothingCategory categoria;
  final ClothingType tipo;
  final Cores cor;
  final Style estilo;
  final List<Weather> clima;
  final List<Occasion> ocasiao;
  final bool disponivel;
  final String imagemUrl;

  Clothing({
    required this.id,
    required this.userId,
    required this.nome,
    required this.categoria,
    required this.tipo,
    required this.cor,
    required this.estilo,
    required this.clima,
    required this.ocasiao,
    required this.disponivel,
    required this.imagemUrl,
  });

  Clothing copyWith({
    String? id,
    String? userId,
    String? nome,
    ClothingCategory? categoria,
    ClothingType? tipo,
    Cores? cor,
    Style? estilo,
    List<Weather>? clima,
    List<Occasion>? ocasiao,
    bool? disponivel,
    String? imagemUrl,
  }) {
    return Clothing(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      nome: nome ?? this.nome,
      categoria: categoria ?? this.categoria,
      tipo: tipo ?? this.tipo,
      cor: cor ?? this.cor,
      estilo: estilo ?? this.estilo,
      clima: clima ?? this.clima,
      ocasiao: ocasiao ?? this.ocasiao,
      disponivel: disponivel ?? this.disponivel,
      imagemUrl: imagemUrl ?? this.imagemUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'nome': nome,
      'categoria': categoria.name,
      'tipo': tipo.name,
      'cor': cor.name,
      'estilo': estilo.name,
      'clima': clima.map((e) => e.name).toList(),
      'ocasiao': ocasiao.map((e) => e.name).toList(),
      'disponivel': disponivel,
      'image_url': imagemUrl,
    };
  }

  factory Clothing.fromJson(
      String id,
      Map<String, dynamic> json,
      ) {
    return Clothing(
      id: id,
      userId: json['user_id'],
      nome: json['nome'],
      categoria: ClothingCategory.values.firstWhere(
            (e) => e.name == json['categoria'],
      ),
      tipo: ClothingType.values.firstWhere(
            (e) => e.name == json['tipo'],
      ),
      cor: Cores.values.firstWhere(
            (e) => e.name == json['cor'],
      ),
      estilo: Style.values.firstWhere(
            (e) => e.name == json['estilo'],
      ),
      clima: (json['clima'] as List)
          .map(
            (e) => Weather.values.firstWhere(
              (w) => w.name == e,
        ),
      )
          .toList(),
      ocasiao: (json['ocasiao'] as List)
          .map(
            (e) => Occasion.values.firstWhere(
              (o) => o.name == e,
        ),
      )
          .toList(),
      disponivel: json['disponivel'] ?? false,
      imagemUrl: json['image_url'],
    );
  }
}
