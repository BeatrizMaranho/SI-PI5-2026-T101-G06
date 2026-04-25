import 'package:flutter/material.dart';
import 'package:project_appetit/screens/home_screen.dart';
import 'package:project_appetit/screens/manage_children_screen.dart';
import 'package:project_appetit/screens/profile_screen.dart';
import 'package:project_appetit/screens/upload_photos_screen.dart';
import 'package:project_appetit/screens/documents_screen.dart'; // 1. IMPORTAR A TELA NOVA
import 'custom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutQuart,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const BouncingScrollPhysics(),
        // children define a ordem das telas na Nav Bar
        children: [
          const HomeScreen(),            // Index 0
          const ManageChildrenScreen(),  // Index 1
          const UploadPhotosScreen(),    // Index 2
          DocumentsScreen(),             // 2. TROCAR O TEXTO PELA TELA (Index 3)
          const ProfileScreen(),         // Index 4
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}