import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livros/repository/auth_repository.dart';
import 'package:livros/screen/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color mainColor = Colors.orange.shade700;
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => AuthRepository(),
        child: LoginScreen(),
      ),
      theme: ThemeData(
        scaffoldBackgroundColor: mainColor,
        textTheme: TextTheme(
          titleSmall: TextStyle(color: Colors.grey.shade700),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor).copyWith(
          surface: Colors.orange.shade100,
          primary: mainColor,
          onPrimary: Colors.white,
          inversePrimary: mainColor.withOpacity(0.6),
        ),
        inputDecorationTheme: InputDecorationTheme(
          // floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          fillColor: Colors.white.withOpacity(0.6),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.white, width: 0.2),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.white, width: 0.2),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.white, width: 0.2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            textStyle: WidgetStateProperty.all<TextStyle>(
                TextStyle(color: Colors.black)),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
