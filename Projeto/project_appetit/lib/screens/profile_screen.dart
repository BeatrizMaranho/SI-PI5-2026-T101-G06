import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../config/routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text(
          'Tela Perfil',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentRoute: AppRoutes.profile),
    );
  }
}
