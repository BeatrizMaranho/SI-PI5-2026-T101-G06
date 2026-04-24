import 'package:flutter/material.dart';
import '../config/routes.dart';

class BottomNavBar extends StatelessWidget {
  final String currentRoute;

  const BottomNavBar({
    super.key,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(), // Faz o recorte para o botão central
      notchMargin: 8.0,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Lado Esquerdo
            _buildNavItem(context, Icons.home_outlined, AppRoutes.home, currentRoute == AppRoutes.home),
            _buildNavItem(context, Icons.people_outline, AppRoutes.people, currentRoute == AppRoutes.people),
            
            const SizedBox(width: 40), // Espaço para o FloatingActionButton central

            // Lado Direito
            _buildNavItem(context, Icons.description_outlined, AppRoutes.documents, currentRoute == AppRoutes.documents),
            _buildNavItem(context, Icons.person_outline, AppRoutes.profile, currentRoute == AppRoutes.profile),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String route, bool isSelected) {
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? const Color(0xFFFF6B4A) : Colors.grey,
        size: 28,
      ),
      onPressed: () {
        if (currentRoute != route) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
    );
  }
}