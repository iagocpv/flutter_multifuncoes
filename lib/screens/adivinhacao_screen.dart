import 'dart:math';
import 'package:flutter/material.dart';

class JogoAdivinhacaoScreen extends StatefulWidget {
  const JogoAdivinhacaoScreen({super.key});

  @override
  State<JogoAdivinhacaoScreen> createState() => _JogoAdivinhacaoScreenState();
}

class _JogoAdivinhacaoScreenState extends State<JogoAdivinhacaoScreen> {
  final TextEditingController _palpiteController = TextEditingController();
  late int _numeroSecreto;
  int _tentativasRestantes = 5;
  String _mensagem = '';
  bool _jogoEncerrado = false;

  void _iniciarNovoJogo() {
    setState(() {
      _numeroSecreto = Random().nextInt(10) + 1; // de 1 a 10
      _tentativasRestantes = 5;
      _mensagem = '';
      _jogoEncerrado = false;
      _palpiteController.clear();
    });
  }

  void _verificarPalpite() {
    if (_jogoEncerrado) return;

    final palpite = int.tryParse(_palpiteController.text);
    if (palpite == null || palpite < 1 || palpite > 10) {
      setState(() {
        _mensagem = 'Digite um número válido entre 1 e 10.';
      });
      return;
    }

    setState(() {
      _tentativasRestantes--;

      if (palpite == _numeroSecreto) {
        _mensagem = 'Parabéns! Você acertou!';
        _jogoEncerrado = true;
      } else if (_tentativasRestantes == 0) {
        _mensagem = 'Suas tentativas acabaram! O número era $_numeroSecreto.';
        _jogoEncerrado = true;
      } else if (palpite < _numeroSecreto) {
        _mensagem = 'Muito baixo! Tente novamente.';
      } else {
        _mensagem = 'Muito alto! Tente novamente.';
      }

      _palpiteController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _iniciarNovoJogo();
  }

  @override
  void dispose() {
    _palpiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jogo de Adivinhação')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Adivinhe o número entre 1 e 10',
              style: Theme.of(context).textTheme.titleLarge
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _palpiteController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Seu palpite',
                border: OutlineInputBorder(),
              ),
              enabled: !_jogoEncerrado,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _jogoEncerrado ? null : _verificarPalpite,
              child: const Text('Enviar'),
            ),
            const SizedBox(height: 20),
            Text(
              _mensagem,
              style: TextStyle(
                fontSize: 16,
                color: _mensagem.contains('Parabéns') ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            Text('Tentativas restantes: $_tentativasRestantes'),
            const SizedBox(height: 20),
            if (_jogoEncerrado)
              ElevatedButton.icon(
                onPressed: _iniciarNovoJogo,
                icon: const Icon(Icons.refresh),
                label: const Text('Novo Jogo'),
              ),
          ],
        ),
      ),
    );
  }
}
