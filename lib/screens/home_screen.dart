import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Multifunções')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.conversor),
              child: const Text('Conversor °C para °F'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.media),
              child: const Text('Calcular Média'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.adivinhacao),
              child: const Text('Jogo de adivinhação'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.desconto),
              child: const Text('Calcular Desconto'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.area),
              child: const Text('Calcular Área do Retângulo'),
            ),
          ),
        ],
      ),
    );
  }
}
