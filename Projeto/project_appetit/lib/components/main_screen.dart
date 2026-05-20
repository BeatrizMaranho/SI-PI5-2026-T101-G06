import 'package:flutter/material.dart';
import 'package:project_appetit/screens/home_screen.dart';
import 'package:project_appetit/screens/manage_children_screen.dart';
import 'package:project_appetit/screens/profile_screen.dart';
import 'package:project_appetit/screens/upload_photos_screen.dart';
import 'package:project_appetit/screens/documents_screen.dart';
import 'custom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  final String userId;

  const MainScreen({super.key, required this.userId});

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
        children: [
          // AJUSTADO: Agora a HomeScreen recebe todos os callbacks de navegação
          HomeScreen(
            onNavigateToManageChildren: () {
              _onItemTapped(1); // Aba Gerenciar Crianças
            },
            onNavigateToProfile: () {
              _onItemTapped(4); // Aba Perfil
            },
            onNavigateToUploadPhotos: () {
              _onItemTapped(2); // Aba de Fotos (UploadPhotosScreen)
            },
            onNavigateToDocuments: () {
              _onItemTapped(3); // Aba de Relatórios (DocumentsScreen)
            },
          ),
          ManageChildrenScreen(userId: widget.userId), // Index 1
          UploadPhotosScreen(),                        // Index 2
          DocumentsScreen(userId: widget.userId),      // Index 3 (Aproveitei para passar o userId correto aqui!)
          ProfileScreen(),                             // Index 4
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}