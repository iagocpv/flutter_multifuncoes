import 'package:flutter/material.dart';

enum Avaliacao { excelente, bom, regular, ruim }

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _comentariosController = TextEditingController();
  Avaliacao? _avaliacaoSelecionada;

  void _enviarFeedback() {
    final nome = _nomeController.text.trim();
    final email = _emailController.text.trim();
    // ignore: unused_local_variable
    final comentarios = _comentariosController.text.trim();

    if (nome.isEmpty || email.isEmpty || _avaliacaoSelecionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha nome, email e avaliação.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Feedback Enviado'),
        content: Text('Obrigado pelo feedback, $nome!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          )
        ],
      ),
    );

    // Simulação de envio - não faz nada real
  }

  Widget _buildRadio(Avaliacao valor, String texto) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<Avaliacao>(
          value: valor,
          groupValue: _avaliacaoSelecionada,
          onChanged: (v) {
            setState(() {
              _avaliacaoSelecionada = v;
            });
          },
        ),
        Text(texto),
      ],
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _comentariosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulário de Feedback')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            const Text('Avaliação do Serviço:'),
            Wrap(
              spacing: 10,
              children: [
                _buildRadio(Avaliacao.excelente, 'Excelente'),
                _buildRadio(Avaliacao.bom, 'Bom'),
                _buildRadio(Avaliacao.regular, 'Regular'),
                _buildRadio(Avaliacao.ruim, 'Ruim'),
              ],
            ),
            TextField(
              controller: _comentariosController,
              decoration: const InputDecoration(labelText: 'Comentários'),
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _enviarFeedback,
              child: const Text('Enviar Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}