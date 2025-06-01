import 'package:flutter/material.dart';

class DescontoScreen extends StatefulWidget {
  const DescontoScreen({super.key});

  @override
  State<DescontoScreen> createState() => _DescontoScreenState();
}

class _DescontoScreenState extends State<DescontoScreen> {
  final List<Map<String, dynamic>> _produtos = [];

  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  final _descontoController = TextEditingController();

  void _adicionarProduto() {
    final nome = _nomeController.text.trim();
    final preco = double.tryParse(_precoController.text);
    final desconto = double.tryParse(_descontoController.text);

    if (nome.isEmpty || preco == null || desconto == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos corretamente.')),
      );
      return;
    }

    setState(() {
      _produtos.add({'nome': nome, 'preco': preco, 'desconto': desconto});
      _nomeController.clear();
      _precoController.clear();
      _descontoController.clear();
    });
  }

  double _precoComDesconto(double preco, double desconto) {
    return preco - (preco * desconto / 100);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    _descontoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de Descontos')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // FORMULÁRIO PARA ADICIONAR PRODUTO
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome do produto'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _precoController,
              decoration: const InputDecoration(labelText: 'Preço (R\$)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descontoController,
              decoration: const InputDecoration(labelText: 'Desconto (%)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _adicionarProduto,
              child: const Text('Adicionar Produto'),
            ),
            const SizedBox(height: 20),
            const Divider(),
            // LISTA DE PRODUTOS
            Expanded(
              child: _produtos.isEmpty
                  ? const Center(child: Text('Nenhum produto cadastrado.'))
                  : ListView.builder(
                      itemCount: _produtos.length,
                      itemBuilder: (context, index) {
                        final produto = _produtos[index];
                        final precoFinal = _precoComDesconto(
                          produto['preco'],
                          produto['desconto'],
                        );

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(produto['nome']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Preço original: R\$ ${produto['preco'].toStringAsFixed(2)}'),
                                Text('Desconto: ${produto['desconto']}%'),
                                Text('Preço com desconto: R\$ ${precoFinal.toStringAsFixed(2)}'),
                              ],
                            ),
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
