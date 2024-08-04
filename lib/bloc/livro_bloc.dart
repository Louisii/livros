import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livros/repository/livro_repository.dart';
import 'livro_event.dart';
import 'livro_state.dart';

class LivroBloc extends Bloc<LivroEvent, LivroState> {
  LivroRepository livroRepository = LivroRepository();

  LivroBloc() : super(LivroInitial()) {
    on<CreateLivro>(_onCreateLivro);
    on<UpdateLivro>(_onUpdateLivro);
    on<DeleteLivro>(_onDeleteLivro);
    on<FetchLivros>(_onFetchLivros);
    on<UpdateIndice>(_onUpdateIndice);
    on<RemoveIndice>(_onRemoveIndice);
    on<AddSubindice>(_onAddSubindice);
    on<AddIndice>(_onAddIndice);
  }

  Future<void> _onCreateLivro(
      CreateLivro event, Emitter<LivroState> emit) async {
    if (!event.livro.isValidTitulo) {
      emit(LivroValidationError('Título deve ter pelo menos um caractere'));
      return;
    }

    emit(LivroLoading());
    try {
      await livroRepository.createLivro(event.livro);
      emit(LivroSuccess());
    } catch (e) {
      emit(LivroFailure(e.toString()));
    }
  }

  Future<void> _onUpdateLivro(
      UpdateLivro event, Emitter<LivroState> emit) async {
    if (!event.livro.isValidTitulo) {
      emit(LivroValidationError('Título deve ter pelo menos um caractere'));
      return;
    }

    emit(LivroLoading());
    try {
      await livroRepository.updateLivro(event.id, event.livro);
      emit(LivroSuccess());
    } catch (e) {
      emit(LivroFailure(e.toString()));
    }
  }

  Future<void> _onDeleteLivro(
      DeleteLivro event, Emitter<LivroState> emit) async {
    emit(LivroLoading());
    try {
      await livroRepository.deleteLivro(event.id);
      emit(LivroSuccess());
    } catch (e) {
      emit(LivroFailure(e.toString()));
    }
  }

  Future<void> _onFetchLivros(
      FetchLivros event, Emitter<LivroState> emit) async {
    emit(LivroLoading());
    try {
      final livros = await livroRepository.fetchLivros();
      emit(LivroListLoaded(livros));
    } catch (e) {
      emit(LivroFailure(e.toString()));
    }
  }

  Future<void> _onUpdateIndice(
      UpdateIndice event, Emitter<LivroState> emit) async {
    // Update logic
  }

  Future<void> _onRemoveIndice(
      RemoveIndice event, Emitter<LivroState> emit) async {
    // Remove logic
  }

  Future<void> _onAddSubindice(
      AddSubindice event, Emitter<LivroState> emit) async {
    // Add subindice logic
  }

  Future<void> _onAddIndice(AddIndice event, Emitter<LivroState> emit) async {
    // Add indice logic
  }
}
