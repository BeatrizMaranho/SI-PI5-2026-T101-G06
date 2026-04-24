import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(name: 'home', index: 0),
          _buildNavItem(name: 'kids', index: 1),
          _buildNavItem(name: 'camera', index: 2),
          _buildNavItem(name: 'arquivo', index: 3),
          _buildNavItem(name: 'user', index: 4),
        ],
      ),
    );
  }

  Widget _buildNavItem({required String name, required int index}) {
    final isSelected = selectedIndex == index;
    
    // AJUSTE AQUI: Como você não tem os arquivos 'w', 
    // usamos o mesmo arquivo sempre.
    final String assetPath = 'assets/icons/$name.svg';

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: isSelected ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFF6F3F), 
                  Color(0xFFCD1313),
                ],
              ) : null,
              boxShadow: isSelected ? [
                BoxShadow(
                  color: const Color(0xFFCD1313).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ] : [],
            ),
            child: Center(
              child: SvgPicture.asset(
                assetPath,
                width: 24,
                height: 24,
                // O segredo está aqui: o código pinta de branco se estiver selecionado
                colorFilter: ColorFilter.mode(
                  isSelected ? Colors.white : const Color(0xFF2D2D2D), 
                  BlendMode.srcIn
                ),
                // Se der erro, mostraremos o ícone de erro padrão do Material
                placeholderBuilder: (context) => Icon(
                  Icons.error_outline, 
                  size: 18, 
                  color: isSelected ? Colors.white : Colors.red
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}