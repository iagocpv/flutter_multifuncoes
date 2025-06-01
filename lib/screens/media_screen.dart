import 'package:flutter/material.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({super.key});

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  final TextEditingController _n1 = TextEditingController();
  final TextEditingController _n2 = TextEditingController();
  final TextEditingController _n3 = TextEditingController();
  String _resultado = '';

  void _calcularMedia() {
    final double? nota1 = double.tryParse(_n1.text);
    final double? nota2 = double.tryParse(_n2.text);
    final double? nota3 = double.tryParse(_n3.text);
    if (nota1 != null && nota2 != null && nota3 != null) {
      final media = (nota1 + nota2 + nota3) / 3;
      setState(() {
        _resultado = 'Média: ${media.toStringAsFixed(2)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calcular Média')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _n1, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Nota 1')),
            TextField(controller: _n2, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Nota 2')),
            TextField(controller: _n3, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Nota 3')),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _calcularMedia, child: const Text('Calcular')),
            const SizedBox(height: 16),
            Text(_resultado, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}