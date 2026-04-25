import 'package:flutter/material.dart';

class AppConstants {
  // --- CORES ---
  static const Color backgroundColor = Color(0xFFFFF8F5);
  static const Color primaryOrange = Color(0xDC5830);
  static const Color borderOrange = Color(0xF67B55); 
  static const Color textBlack = Color(0xFF231F20);
  static const Color textGrey = Color(0xFF757575);
  static const Color iconLight = Colors.white;
  static const Color cardWhite = Colors.white; // Adicionado para corrigir o erro nas outras telas

  // --- ESTILOS DE TEXTO ---

  static const TextStyle titleStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: textBlack,
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
  static const double cardPadding = 18.0;
  static const double elementSpacing = 25.0;
  
  static const double borderRadius = 25.0;
  static const double buttonBorderRadius = 15.0;
  static const double navBarRadius = 30.0;

  static const double navBarHeight = 85.0;
  static const double centralButtonSize = 65.0;
}