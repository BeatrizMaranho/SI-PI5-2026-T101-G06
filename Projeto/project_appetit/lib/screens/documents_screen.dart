import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../config/routes.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. O CONTEÚDO DA TELA
      body: const Center(child: Text("Bem-vindo à Documentos")),

      // 2. O BOTÃO DA CÂMERA (O segredo do design)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 65,
        width: 65,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7A082), Color(0xFFE35D33)],
          ),
        ),
        child: FloatingActionButton(
          onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.uploadPhotos),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.camera_alt, color: Colors.white, size: 30),
        ),
      ),

      // 3. A BARRA QUE VOCÊ CRIOU
      bottomNavigationBar: const BottomNavBar(currentRoute: AppRoutes.documents),
    );
  }
}


