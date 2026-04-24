import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../config/routes.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pessoas'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text(
          'Tela Pessoas',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentRoute: AppRoutes.people),
    );
  }
}
