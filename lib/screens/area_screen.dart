import 'package:flutter/material.dart';

class AreaScreen extends StatefulWidget {
  const AreaScreen({super.key});

  @override
  State<AreaScreen> createState() => _AreaScreenState();
}

class _AreaScreenState extends State<AreaScreen> {
  final TextEditingController _largura = TextEditingController();
  final TextEditingController _altura = TextEditingController();
  String _resultado = '';

  void _calcularArea() {
    final double? l = double.tryParse(_largura.text);
    final double? a = double.tryParse(_altura.text);
    if (l != null && a != null) {
      final area = l * a;
      setState(() {
        _resultado = 'Área: ${area.toStringAsFixed(2)} m²';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Área do Retângulo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _largura, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Largura (m)')),
            TextField(controller: _altura, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Altura (m)')),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _calcularArea, child: const Text('Calcular')),
            const SizedBox(height: 16),
            Text(_resultado, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}