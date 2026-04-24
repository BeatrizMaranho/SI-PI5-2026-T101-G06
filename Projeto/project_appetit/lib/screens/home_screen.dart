import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. O CONTEÚDO DA TELA
      body: const Center(child: Text("Bem-vindo à Home"))
    );
  }
}