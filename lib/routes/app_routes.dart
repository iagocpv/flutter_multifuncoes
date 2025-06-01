import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/conversor_screen.dart';
import '../screens/media_screen.dart';
import '../screens/desconto_screen.dart';
import '../screens/area_screen.dart';
import '../screens/adivinhacao_screen.dart';
import '../screens/lista_compras_screen.dart';
import '../screens/tarefas_screen.dart';
import '../screens/notas_screen.dart';
import '../screens/feedback_screen.dart';

class AppRoutes {
  static const home = '/';
  static const conversor = '/conversor';
  static const media = '/media';
  static const desconto = '/desconto';
  static const area = '/area';
  static const adivinhacao = '/adivinhacao';
  static const listaCompras = '/lista_compras';
  static const tarefas = '/tarefas';
  static const notas = '/notas';
  static const feedback = '/feedback';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    conversor: (context) => const ConversorScreen(),
    media: (context) => const MediaScreen(),
    desconto: (context) => const DescontoScreen(),
    adivinhacao: (context) => const JogoAdivinhacaoScreen(),
    area: (context) => const AreaScreen(),
    listaCompras: (context) => const ListaComprasScreen(),
    tarefas: (context) => const TarefasScreen(),
    notas: (context) => const NotasScreen(),
    feedback: (context) => const FeedbackScreen(),
  };
}