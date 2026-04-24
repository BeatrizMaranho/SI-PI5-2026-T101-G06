import 'package:flutter/material.dart';
import 'package:project_appetit/constants.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.navBarHeight,
      decoration: BoxDecoration(
        color: AppConstants.cardWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppConstants.navBarRadius),
          topRight: Radius.circular(AppConstants.navBarRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(icon: Icons.home_outlined, activeIcon: Icons.home, index: 0),
          _buildNavItem(icon: Icons.people_outline, activeIcon: Icons.people, index: 1),
          _buildNavItem(icon: Icons.camera_alt_outlined, activeIcon: Icons.camera_alt, index: 2),
          _buildNavItem(icon: Icons.note_add_outlined, activeIcon: Icons.note_add, index: 3),
          _buildNavItem(icon: Icons.person_outline, activeIcon: Icons.person, index: 4),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon, 
    required IconData activeIcon, 
    required int index
  }) {
    final isSelected = selectedIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: AppConstants.centralButtonSize,
            height: AppConstants.centralButtonSize,
            decoration: BoxDecoration(
              // Aplica o fundo vermelho apenas se estiver selecionado
              color: isSelected ? AppConstants.primaryOrange : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              boxShadow: isSelected ? [
                BoxShadow(
                  color: AppConstants.primaryOrange.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ] : [],
            ),
            child: Icon(
              isSelected ? activeIcon : icon,
              size: 28,
              // Ícone branco se selecionado, preto/cinza se não
              color: isSelected ? AppConstants.iconLight : AppConstants.textBlack,
            ),
          ),
        ),
      ),
    );
  }
}