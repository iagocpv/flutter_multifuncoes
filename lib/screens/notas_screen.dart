import 'package:flutter/material.dart';

class Nota {
  String titulo;
  String conteudo;

  Nota({required this.titulo, required this.conteudo});
}

class NotasScreen extends StatefulWidget {
  const NotasScreen({super.key});

  @override
  State<NotasScreen> createState() => _NotasScreenState();
}

class _NotasScreenState extends State<NotasScreen> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _conteudoController = TextEditingController();
  final List<Nota> _notas = [];
  Nota? _notaSelecionada;

  void _adicionarNota() {
    final titulo = _tituloController.text.trim();
    final conteudo = _conteudoController.text.trim();
    if (titulo.isEmpty || conteudo.isEmpty) return;

    setState(() {
      _notas.add(Nota(titulo: titulo, conteudo: conteudo));
      _tituloController.clear();
      _conteudoController.clear();
    });
  }

  void _selecionarNota(Nota nota) {
    setState(() {
      _notaSelecionada = nota;
    });
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _conteudoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notas Rápidas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _conteudoController,
              decoration: const InputDecoration(labelText: 'Conteúdo'),
              maxLines: 4,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _adicionarNota,
              child: const Text('Adicionar Nota'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _notas.isEmpty
                  ? const Center(child: Text('Nenhuma nota adicionada.'))
                  : ListView.builder(
                      itemCount: _notas.length,
                      itemBuilder: (context, index) {
                        final nota = _notas[index];
                        return ListTile(
                          title: Text(nota.titulo),
                          onTap: () => _selecionarNota(nota),
                        );
                      },
                    ),
            ),
            if (_notaSelecionada != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_notaSelecionada!.titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 10),
                        Text(_notaSelecionada!.conteudo),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
