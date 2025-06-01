import 'package:flutter/material.dart';

class ListaComprasScreen extends StatefulWidget {
  const ListaComprasScreen({super.key});

  @override
  State<ListaComprasScreen> createState() => _ListaComprasScreenState();
}

class _ListaComprasScreenState extends State<ListaComprasScreen> {
  final TextEditingController _itemController = TextEditingController();
  final List<Map<String, dynamic>> _itens = [];

  void _adicionarItem() {
    final texto = _itemController.text.trim();
    if (texto.isEmpty) return;

    setState(() {
      _itens.add({'nome': texto, 'comprado': false});
      _itemController.clear();
    });
  }

  void _removerItem(int index) {
    setState(() {
      _itens.removeAt(index);
    });
  }

  void _toggleComprado(int index) {
    setState(() {
      _itens[index]['comprado'] = !_itens[index]['comprado'];
    });
  }

  @override
  void dispose() {
    _itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Compras')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _itemController,
              decoration: InputDecoration(
                labelText: 'Adicionar item',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _adicionarItem,
                ),
              ),
              onSubmitted: (_) => _adicionarItem(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _itens.isEmpty
                  ? const Center(child: Text('Nenhum item na lista.'))
                  : ListView.builder(
                      itemCount: _itens.length,
                      itemBuilder: (context, index) {
                        final item = _itens[index];
                        return ListTile(
                          leading: Checkbox(
                            value: item['comprado'],
                            onChanged: (_) => _toggleComprado(index),
                          ),
                          title: Text(
                            item['nome'],
                            style: TextStyle(
                              decoration: item['comprado'] ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removerItem(index),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
