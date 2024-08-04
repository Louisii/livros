import 'package:flutter/material.dart';

class ListaDeLivrosScreen extends StatelessWidget {
  const ListaDeLivrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null,
      body: Column(
        children: [
          ListTile(
            title: Text("nome do livro"),
          )
        ],
      ),
    );
  }
}
