import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../config/routes.dart';

class UploadPhotosScreen extends StatelessWidget {
  const UploadPhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar refeições'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text(
          'Tela Upload de Fotos',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentRoute: AppRoutes.uploadPhotos),
    );
  }
}
