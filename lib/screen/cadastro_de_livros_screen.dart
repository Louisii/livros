import 'package:flutter/material.dart';
import 'package:livros/model/indice.dart';
import 'package:livros/model/livro.dart';
import 'package:livros/repository/livro_repository.dart';
import 'package:livros/widget/frosted_glass_card.dart';
import 'package:livros/widget/indice_widget.dart';
import 'package:livros/widget/add_indice_widget.dart'; // Importar o widget AddIndiceWidget

class CadastroDeLivrosScreen extends StatefulWidget {
  final Livro? livro;

  const CadastroDeLivrosScreen({Key? key, this.livro}) : super(key: key);

  @override
  _CadastroDeLivrosScreenState createState() => _CadastroDeLivrosScreenState();
}

class _CadastroDeLivrosScreenState extends State<CadastroDeLivrosScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  List<Indice?> _indices = [];

  @override
  void initState() {
    super.initState();
    if (widget.livro != null) {
      _tituloController.text = widget.livro!.titulo;
      _indices = widget.livro!.indices;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.livro == null ? 'Cadastrar Livro' : 'Editar Livro'),
      ),
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
          SafeArea(
            child: _buildForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FrostedGlassCard(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _tituloField(),
              _indicesList(),
              const SizedBox(height: 20),
              _addIndiceButton(), // Substituir o formulário de adição por um botão
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _saveBook,
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tituloField() {
    return TextFormField(
      controller: _tituloController,
      decoration: const InputDecoration(
        labelText: 'Título',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Título deve ter pelo menos um caractere';
        }
        return null;
      },
    );
  }

  Widget _indicesList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _indices.length,
        itemBuilder: (context, index) {
          final indice = _indices[index];
          return IndiceWidget(
            indice: indice!,
            onIndiceUpdated: (updatedIndice) {
              setState(() {
                _indices[index] = updatedIndice;
              });
            },
            onRemove: () {
              setState(() {
                _indices.removeAt(index);
              });
            },
          );
        },
      ),
    );
  }

  Widget _addIndiceButton() {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AddIndiceWidget(
              onAdd: (titulo, pagina) {
                setState(() {
                  _indices.add(
                      Indice(titulo: titulo, pagina: pagina, subindices: []));
                });
              },
            );
          },
        );
      },
      child: const Text('Adicionar Índice'),
    );
  }

  Future<void> _saveBook() async {
    if (_formKey.currentState?.validate() ?? false) {
      final livro = Livro(
        id: widget.livro?.id ?? 0,
        titulo: _tituloController.text,
        indices: _indices,
      );

      LivroRepository repo = LivroRepository();
      if (widget.livro == null) {
        await repo.createLivro(livro);
      } else {
        await repo.updateLivro(livro.id!, livro);
      }

      Navigator.pop(context);
    }
  }
}
