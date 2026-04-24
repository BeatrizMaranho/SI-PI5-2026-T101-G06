import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../config/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text(
          'Tela Home',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentRoute: AppRoutes.home),
    );
  }
}
