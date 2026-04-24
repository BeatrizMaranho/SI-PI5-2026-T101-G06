import 'package:flutter/material.dart';
import '../config/routes.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Lado Esquerdo
            _buildNavItem(Icons.home_outlined, 0, currentIndex == 0),
            _buildNavItem(Icons.people_outline, 1, currentIndex == 1),
            
            const SizedBox(width: 40), // Espaço para o botão da câmera

            // Lado Direito
            _buildNavItem(Icons.description_outlined, 2, currentIndex == 2),
            _buildNavItem(Icons.person_outline, 3, currentIndex == 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, bool isSelected) {
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? const Color(0xFFFF6B4A) : Colors.grey,
        size: 28,
      ),
      onPressed: () => onTap(index), // Apenas avisa o Layout Pai qual foi clicado
    );
  }
}