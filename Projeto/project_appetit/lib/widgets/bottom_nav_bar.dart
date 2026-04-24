import 'package:flutter/material.dart';
import '../config/routes.dart';

class BottomNavBar extends StatelessWidget {
  final String currentRoute;

  const BottomNavBar({
    super.key,
    required this.currentRoute,
  });

  int _getSelectedIndex() {
    switch (currentRoute) {
      case AppRoutes.home:
        return 0;
      case AppRoutes.people:
        return 1;
      case AppRoutes.uploadPhotos:
        return 2;
      case AppRoutes.documents:
        return 3;
      case AppRoutes.profile:
        return 4;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _getSelectedIndex(),
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFFFF6B4A),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Pessoas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: 'Fotos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.description),
          label: 'Documentos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
      onTap: (index) {
        final routes = [
          AppRoutes.home,
          AppRoutes.people,
          AppRoutes.uploadPhotos,
          AppRoutes.documents,
          AppRoutes.profile,
        ];
        Navigator.pushReplacementNamed(context, routes[index]);
      },
    );
  }
}
