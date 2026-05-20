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
      // Aumentamos ligeiramente a altura caso precise acomodar melhor o texto com segurança
      height: AppConstants.navBarHeight + 10,
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
    final String assetPath = 'assets/icons/$name.svg';

    // Mapeia o nome do asset interno para a legenda correspondente visível
    final Map<String, String> legendas = {
      'home': 'Início',
      'kids': 'Crianças',
      'camera': 'Imagens',
      'arquivo': 'Relatório',
      'user': 'Perfil',
    };

    final String textoLegenda = legendas[name] ?? '';

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 60, // Ligeiramente ajustado para o layout vertical do texto
            height: 60,
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
              // Alterado para um Column para empilhar Ícone + Legenda perfeitamente
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    assetPath,
                    width: 22,
                    height: 22,
                    colorFilter: ColorFilter.mode(
                      isSelected ? Colors.white : const Color(0xFF2D2D2D), 
                      BlendMode.srcIn
                    ),
                    placeholderBuilder: (context) => Icon(
                      Icons.error_outline, 
                      size: 18, 
                      color: isSelected ? Colors.white : Colors.red
                    ),
                  ),
                  const SizedBox(height: 3), // Espaçamento fino entre o ícone e o texto
                  Text(
                    textoLegenda,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      // O texto herda a mesma lógica de cor do ícone
                      color: isSelected ? Colors.white : const Color(0xFF2D2D2D),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}