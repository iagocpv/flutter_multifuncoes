import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CidadesScreen extends StatefulWidget {
  const CidadesScreen({super.key});

  @override
  State<CidadesScreen> createState() => _PesquisaCidadesScreenState();
}

class _PesquisaCidadesScreenState extends State<CidadesScreen> {
  final List<String> _estados = [
    'AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA',
    'PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'
  ];

  String _estadoSelecionado = 'SP';
  TextEditingController? _campoController;

  List<String> _cidades = [];
  String? _cidadeSelecionada;
  bool _carregando = false;

  Future<void> _buscarCidades(String uf) async {
    setState(() {
      _carregando = true;
      _cidadeSelecionada = null;
      _cidades = [];
    });

    final url = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados/$uf/municipios';
    final resposta = await http.get(Uri.parse(url));
    if (!mounted) return;

    if (resposta.statusCode == 200) {
      final dados = json.decode(resposta.body);
      setState(() {
        _cidades = List<String>.from(dados.map((item) => item['nome']));
        _carregando = false;
      });
    } else {
      setState(() => _carregando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar cidades.')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _buscarCidades(_estadoSelecionado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesquisa de Cidades')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _carregando
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selecione o estado (UF):',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    value: _estadoSelecionado,
                    items: _estados.map((uf) {
                      return DropdownMenuItem<String>(
                        value: uf,
                        child: Text(uf),
                      );
                    }).toList(),
                    onChanged: (String? novoUF) {
                      if (novoUF != null) {
                        setState(() {
                          _estadoSelecionado = novoUF;
                        });
                        _buscarCidades(novoUF);
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Digite o nome da cidade:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return _cidades.where((cidade) =>
                          cidade.toLowerCase().startsWith(textEditingValue.text.toLowerCase()));
                    },
                    onSelected: (String selecao) {
                      setState(() {
                        _cidadeSelecionada = selecao;
                      });
                      _campoController?.clear();
                    },
                    fieldViewBuilder: (context, textEditingController, focusNode, onEditingComplete) {
                      _campoController = textEditingController;
                      return TextField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        onEditingComplete: onEditingComplete,
                        decoration: const InputDecoration(
                          labelText: 'Cidade',
                          border: OutlineInputBorder(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  if (_cidadeSelecionada != null)
                    Text(
                      'Cidade selecionada: $_cidadeSelecionada',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
      ),
    );
  }
}
