import 'package:flutter/material.dart';

class ConversorScreen extends StatefulWidget {
  const ConversorScreen({super.key});

  @override
  State<ConversorScreen> createState() => _ConversorScreenState();
}

class _ConversorScreenState extends State<ConversorScreen> {
  final TextEditingController _controller = TextEditingController();
  String _resultado = '';

  void _converter() {
    final double? celsius = double.tryParse(_controller.text);
    if (celsius != null) {
      final fahrenheit = (celsius * 9 / 5) + 32;
      setState(() {
        _resultado = '$celsius °C = ${fahrenheit.toStringAsFixed(2)} °F';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversor °C para °F')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Temperatura em °C'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _converter, child: const Text('Converter')),
            const SizedBox(height: 16),
            Text(_resultado, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}