import 'package:equatable/equatable.dart';
import 'package:livros/model/indice.dart';
import 'package:livros/model/livro.dart';

abstract class LivroEvent extends Equatable {
  const LivroEvent();

  @override
  List<Object?> get props => [];
}

class FetchLivros extends LivroEvent {}

class CreateLivro extends LivroEvent {
  final Livro livro;

  const CreateLivro(this.livro);
}

class UpdateLivro extends LivroEvent {
  final int id;
  final Livro livro;

  const UpdateLivro(this.id, this.livro);
}

class DeleteLivro extends LivroEvent {
  final int id;

  const DeleteLivro(this.id);
}

class UpdateIndice extends LivroEvent {
  final Indice indice;

  UpdateIndice(this.indice);
}

class RemoveIndice extends LivroEvent {
  final Indice indice;

  RemoveIndice(this.indice);
}

class AddSubindice extends LivroEvent {
  final Indice indice;

  AddSubindice(this.indice);
}

class AddIndice extends LivroEvent {}
