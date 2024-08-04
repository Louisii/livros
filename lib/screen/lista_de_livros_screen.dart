import 'package:flutter/material.dart';
import 'package:livros/model/livro.dart';
import 'package:livros/repository/livro_repository.dart';
import 'package:livros/screen/cadastro_de_livros_screen.dart';
import 'package:livros/widget/frosted_glass_card.dart';

class ListaDeLivrosScreen extends StatefulWidget {
  const ListaDeLivrosScreen({super.key});

  @override
  _ListaDeLivrosScreenState createState() => _ListaDeLivrosScreenState();
}

class _ListaDeLivrosScreenState extends State<ListaDeLivrosScreen> {
  late Future<List<Livro>> _futureLivros;

  @override
  void initState() {
    super.initState();
    _futureLivros = fetchLivros();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white.withOpacity(0.6),
      //   elevation: 0.0,
      //   title: Text("Livros"),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroDeLivrosScreen()),
          ).then((_) {
            setState(() {
              _futureLivros = fetchLivros();
            });
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg/bg1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: FutureBuilder<List<Livro>>(
              future: _futureLivros,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhum livro encontrado'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final livro = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FrostedGlassCard(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(
                              livro.titulo,
                              style: theme.textTheme.titleMedium,
                            ),
                            subtitle: Text(
                                'Índices: ${livro.indices.map((indice) => indice?.titulo).join(', ')}'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CadastroDeLivrosScreen(
                                    livro: livro,
                                  ),
                                ),
                              ).then((_) {
                                setState(() {
                                  _futureLivros = fetchLivros();
                                });
                              });
                            },
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _confirmDelete(context, livro.id!),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Livro>> fetchLivros() async {
    LivroRepository repo = LivroRepository();
    return await repo.fetchLivros();
  }

  Future<void> deleteLivro(int id) async {
    LivroRepository repo = LivroRepository();
    await repo.deleteLivro(id);
  }

  void _confirmDelete(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content:
              const Text('Você tem certeza que deseja excluir este livro?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () async {
                await deleteLivro(id);
                Navigator.of(context).pop();
                setState(() {
                  _futureLivros = fetchLivros();
                });
              },
            ),
          ],
        );
      },
    );
  }
}
