class Indice {
  final String titulo;
  final int pagina;
  final List<Indice?> subindices;
  final int? id;

  Indice({
    required this.titulo,
    required this.pagina,
    required this.subindices,
    this.id,
  });

  factory Indice.fromJson(Map<String, dynamic> json) {
    return Indice(
      titulo: json['titulo'],
      pagina: json['pagina'],
      subindices: (json['subindices'] as List)
          .map((subindice) => Indice.fromJson(subindice))
          .toList(),
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'pagina': pagina,
      'subindices': subindices.map((subindice) => subindice?.toJson()).toList(),
      "id": id,
    };
  }

  Indice copyWith({
    String? titulo,
    int? pagina,
    List<Indice>? subindices,
  }) {
    return Indice(
      titulo: titulo ?? this.titulo,
      pagina: pagina ?? this.pagina,
      subindices: subindices ?? this.subindices,
    );
  }
}
