import 'package:equatable/equatable.dart';
import 'package:livros/model/livro.dart';
import 'form_status.dart';

abstract class LivroState extends Equatable {
  final Livro? livro;

  LivroState({
    this.livro,
  });

  @override
  List<Object?> get props => [livro];
}

class LivroInitial extends LivroState {
  LivroInitial() : super(livro: null);
}

class LivroLoading extends LivroState {
  LivroLoading() : super(livro: null);
}

class LivroSuccess extends LivroState {
  LivroSuccess() : super(livro: null);
}

class LivroFailure extends LivroState {
  final String error;

  LivroFailure(this.error, {Livro? livro}) : super(livro: livro);

  @override
  List<Object?> get props => [error, livro];
}

class LivroValidationError extends LivroState {
  final String error;

  LivroValidationError(this.error, {Livro? livro}) : super(livro: livro);

  @override
  List<Object?> get props => [error, livro];
}

class LivroListLoaded extends LivroState {
  final List<Livro> livros;

  LivroListLoaded(this.livros) : super(livro: null);

  @override
  List<Object?> get props => [livros];
}

class LivroFormState extends LivroState {
  final FormStatus formStatus;

  LivroFormState(this.formStatus, {Livro? livro}) : super(livro: livro);

  @override
  List<Object?> get props => [formStatus, livro];
}
