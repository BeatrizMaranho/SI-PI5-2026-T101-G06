import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retornamos apenas o que é específico desta aba.
    // O menu e o botão laranja "flutuam" por cima disso através do MainLayout.
    return const Center(
      child: Text(
        "Bem-vindo à Home",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}