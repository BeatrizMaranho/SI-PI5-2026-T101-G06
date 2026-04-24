import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../config/routes.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documentos'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text(
          'Tela Documentos',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentRoute: AppRoutes.documents),
    );
  }
}
