import 'package:flutter/material.dart';
import 'package:livros/model/indice.dart';

class IndiceWidget extends StatefulWidget {
  final Indice indice;
  final ValueChanged<Indice> onIndiceUpdated;
  final VoidCallback onRemove;

  const IndiceWidget({
    Key? key,
    required this.indice,
    required this.onIndiceUpdated,
    required this.onRemove,
  }) : super(key: key);

  @override
  _IndiceWidgetState createState() => _IndiceWidgetState();
}

class _IndiceWidgetState extends State<IndiceWidget> {
  late TextEditingController _tituloController;
  late TextEditingController _paginaController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.indice.titulo);
    _paginaController =
        TextEditingController(text: widget.indice.pagina.toString());
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _paginaController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // Save changes when exiting edit mode
        widget.onIndiceUpdated(
          widget.indice.copyWith(
            titulo: _tituloController.text,
            pagina: int.parse(_paginaController.text),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Divider(color: Colors.black54),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _isEditing
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 160,
                        child: TextField(
                          controller: _tituloController,
                          decoration: const InputDecoration(
                            labelText: 'Título',
                          ),
                        ),
                      ),
                    )
                  : Text(_tituloController.text,
                      style: theme.textTheme.titleMedium),
              _isEditing
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 100,
                        child: TextField(
                          controller: _paginaController,
                          decoration:
                              const InputDecoration(labelText: 'Página'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    )
                  : Text("página ${_paginaController.text}"),
            ],
          ),
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: _toggleEditing,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: widget.onRemove,
          ),
          Divider()
        ],
      ),
    );
  }
}
