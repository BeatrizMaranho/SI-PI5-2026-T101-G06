import 'package:flutter/material.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retornamos apenas o que é específico desta aba.
    // O menu e o botão laranja "flutuam" por cima disso através do MainLayout.
    return const Center(
      child: Text(
        "Bem-vindo à Documentos",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}