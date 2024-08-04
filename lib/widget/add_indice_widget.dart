import 'package:flutter/material.dart';

class AddIndiceWidget extends StatefulWidget {
  final Function(String, int) onAdd;

  const AddIndiceWidget({Key? key, required this.onAdd}) : super(key: key);

  @override
  _AddIndiceWidgetState createState() => _AddIndiceWidgetState();
}

class _AddIndiceWidgetState extends State<AddIndiceWidget> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _paginaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Índice'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título do Índice'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _paginaController,
              decoration: const InputDecoration(labelText: 'Página do Índice'),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            final titulo = _tituloController.text;
            final pagina = int.tryParse(_paginaController.text) ?? 0;

            if (titulo.isNotEmpty) {
              widget.onAdd(titulo, pagina);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Adicionar'),
        ),
      ],
    );
  }
}
