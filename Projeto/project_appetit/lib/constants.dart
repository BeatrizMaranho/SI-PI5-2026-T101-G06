import 'package:flutter/material.dart';

class AppConstants {
  // --- CORES (Paleta Unificada) ---

  // Cores mescladas/novas trazidas pela equipe
  static const Color orange = Color(0xFF6F3F3F);
  static const Color red = Color(0xFFCD1313); // Corrigido o valor hexadecimal
  
  // Laranja vibrante principal (Botões e ícone ativo)
  static const Color primaryOrange = Color(0xFFD14D28);

  // Laranja secundário (Usado em estados de hover ou variantes)
  static const Color secundaryOrange = Color(0xFFDC5830); // Corrigido o valor hexadecimal
  
  // Fundo da página (Off-white conforme o layout da Sofia)
  static const Color backgroundColor = Color(0xFFFFF8F5);
  
  // Cores de Texto e Ícones
  static const Color textBlack = Color(0xFF231F20); 
  static const Color textGrey = Color(0xFF757575);  
  static const Color iconLight = Colors.white;      
  static const Color cardWhite = Colors.white;      
  static const Color black = Color(0xFF000000); 

  // --- ESTILOS DE TEXTO ---

  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textBlack,
    fontFamily: 'Inter', 
  );

  static const TextStyle sectionStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textBlack,
  );

  static const TextStyle cardTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: textBlack,
  );

  static const TextStyle lightLabelStyle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: iconLight,
  );

  // --- DIMENSÕES E ESPAÇAMENTOS ---
  
  static const double defaultPadding = 20.0;
  static const double cardPadding = 16.0;
  static const double elementSpacing = 15.0;
  
  static const double borderRadius = 20.0;       // Para os Cards
  static const double buttonBorderRadius = 12.0; // Para os Botões
  static const double navBarRadius = 30.0;       // Para o topo da Nav Bar

  static const double navBarHeight = 85.0;
  static const double centralButtonSize = 65.0;
}