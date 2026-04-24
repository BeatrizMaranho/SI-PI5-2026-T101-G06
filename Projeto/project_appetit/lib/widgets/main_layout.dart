// main_layout.dart
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/people_screen.dart';
import '../screens/documents_screen.dart';
import '../screens/profile_screen.dart';
import '../widgets/bottom_nav_bar.dart';
import '../config/routes.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  // Lista das telas
  final List<Widget> _screens = [
    const HomeScreen(),
    const PeopleScreen(),
    const DocumentsScreen(),
    const ProfileScreen(),
  ];

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack( // Mantém o estado das telas sem recarregar
        index: _currentIndex,
        children: _screens,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  Widget _buildFab() {
    return Container(
      height: 65, width: 65,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFFF7A082), Color(0xFFE35D33)],
        ),
      ),
      child: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.uploadPhotos),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: const Icon(Icons.camera_alt, color: Colors.white, size: 30),
      ),
    );
  }
}