import 'package:flutter/material.dart';

enum Prioridade { baixa, media, alta }

class Tarefa {
  String nome;
  String descricao;
  bool concluida;
  Prioridade prioridade;

  Tarefa({
    required this.nome,
    required this.descricao,
    this.concluida = false,
    this.prioridade = Prioridade.baixa,
  });
}

class TarefasScreen extends StatefulWidget {
  const TarefasScreen({super.key});

  @override
  State<TarefasScreen> createState() => _TarefasScreenState();
}

class _TarefasScreenState extends State<TarefasScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final List<Tarefa> _tarefas = [];
  Prioridade _prioridadeSelecionada = Prioridade.baixa;

  void _adicionarTarefa() {
    final nome = _nomeController.text.trim();
    final descricao = _descricaoController.text.trim();

    if (nome.isEmpty) return;

    setState(() {
      _tarefas.add(Tarefa(
        nome: nome,
        descricao: descricao,
        prioridade: _prioridadeSelecionada,
      ));
      _nomeController.clear();
      _descricaoController.clear();
      _prioridadeSelecionada = Prioridade.baixa;
    });
  }

  void _toggleConcluida(int index) {
    setState(() {
      _tarefas[index].concluida = !_tarefas[index].concluida;
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  Widget _buildRadioPrioridade(Prioridade valor, String texto) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<Prioridade>(
          value: valor,
          groupValue: _prioridadeSelecionada,
          onChanged: (v) {
            if (v != null) {
              setState(() => _prioridadeSelecionada = v);
            }
          },
        ),
        Text(texto),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Tarefas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome da tarefa'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Prioridade: '),
                _buildRadioPrioridade(Prioridade.baixa, 'Baixa'),
                _buildRadioPrioridade(Prioridade.media, 'Média'),
                _buildRadioPrioridade(Prioridade.alta, 'Alta'),
              ],
            ),
            ElevatedButton(
              onPressed: _adicionarTarefa,
              child: const Text('Adicionar Tarefa'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _tarefas.isEmpty
                  ? const Center(child: Text('Nenhuma tarefa cadastrada.'))
                  : ListView.builder(
                      itemCount: _tarefas.length,
                      itemBuilder: (context, index) {
                        final tarefa = _tarefas[index];
                        return ListTile(
                          leading: Checkbox(
                            value: tarefa.concluida,
                            onChanged: (_) => _toggleConcluida(index),
                          ),
                          title: Text(tarefa.nome),
                          subtitle: Text('${tarefa.descricao}\nPrioridade: ${tarefa.prioridade.name}'),
                          isThreeLine: true,
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
