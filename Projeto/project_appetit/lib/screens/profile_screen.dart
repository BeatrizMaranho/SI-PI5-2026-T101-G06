import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retorna apenas o conteúdo da tela. 
    // O Scaffold com o menu e o botão de câmera já estarão em volta disso no MainLayout.
    return const Center(
      child: Text(
        "Bem-vindo ao Perfil",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}