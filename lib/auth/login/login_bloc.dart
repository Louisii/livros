import 'package:livros/repository/auth_repository.dart';
import 'package:livros/auth/form_submission_status.dart';
import 'package:livros/auth/login/login_event.dart';
import 'package:livros/auth/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;

  LoginBloc({required this.authRepo}) : super(LoginState()) {
    // Username updated
    on<LoginUsernameChanged>(_onUsernameChanged);
    // Password updated
    on<LoginPasswordChanged>(_onPasswordChanged);
    // Form submitted
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onUsernameChanged(
      LoginUsernameChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(username: event.username));
  }

  void _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      await authRepo.login(email: state.username, senha: state.password);
      emit(state.copyWith(formStatus: SubmissionSuccess()));
    } catch (e) {
      emit(state.copyWith(
        formStatus:
            SubmissionFailed(e is Exception ? e : Exception('Unknown error')),
      ));
    }
  }
}
