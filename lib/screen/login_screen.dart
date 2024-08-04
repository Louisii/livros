import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livros/repository/auth_repository.dart';
import 'package:livros/auth/form_submission_status.dart';
import 'package:livros/auth/login/login_bloc.dart';
import 'package:livros/auth/login/login_event.dart';
import 'package:livros/auth/login/login_state.dart';
import 'package:livros/screen/lista_de_livros_screen.dart';
import 'package:livros/widget/frosted_glass_card.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg/bg4.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BlocProvider(
            create: (context) => LoginBloc(
              authRepo: context.read<AuthRepository>(),
            ),
            child: _loginForm(theme),
          ),
        ],
      ),
    );
  }

  Widget _loginForm(theme) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        } else if (formStatus is SubmissionSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ListaDeLivrosScreen()),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: FrostedGlassCard(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.book,
                      size: 100,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  _usernameField(),
                  _passwordField(),
                  _loginButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: const InputDecoration(
            suffixIcon: Icon(Icons.person),
            hintText: 'Usuario',
          ),
          validator: (value) =>
              state.isValidUsername ? null : 'Username is too short',
          onChanged: (value) => context.read<LoginBloc>().add(
                LoginUsernameChanged(username: value),
              ),
        ),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
            suffixIcon: Icon(Icons.security),
            hintText: 'Senha',
          ),
          validator: (value) =>
              state.isValidPassword ? null : 'Password is too short',
          onChanged: (value) => context.read<LoginBloc>().add(
                LoginPasswordChanged(password: value),
              ),
        ),
      );
    });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                },
                child: const Text('Entrar'),
              ),
            );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
