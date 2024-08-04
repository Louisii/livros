import 'package:livros/model/indice.dart';

class Livro {
  final String titulo;
  final List<Indice?> indices;
  final int? id;

  Livro({
    required this.titulo,
    required this.indices,
     this.id,
  });

  bool get isValidTitulo => titulo.isNotEmpty;

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'indices': indices.map((indice) => indice?.toJson()).toList(),
    };
  }

  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      titulo: json['titulo'] as String,
      indices: (json['indices'] as List<dynamic>)
          .map((indice) => Indice.fromJson(indice as Map<String, dynamic>))
          .toList(),
          id: json["id"], 
    );
  }
}
