import 'package:flutter/material.dart';
import 'package:project_appetit/screens/home_screen.dart';
import 'package:project_appetit/screens/people_screen.dart';
import 'package:project_appetit/screens/profile_screen.dart';
import 'package:project_appetit/screens/upload_photos_screen.dart';
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
        // children define a ordem das telas na Nav Bar
        children: const [
          HomeScreen(),               // Index 0
          PeopleScreen(),  // Index 1
          UploadPhotosScreen(),
          Center(child: Text("Documentos")),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}