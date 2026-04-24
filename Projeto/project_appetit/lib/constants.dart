import 'package:flutter/material.dart';

class AppConstants {
  // --- CORES (Paleta extraída da imagem) ---
  
  // Laranja vibrante principal (Botões e ícone ativo)
  static const Color primaryOrange = Color(0xFFE44A32);
  
  // Fundo da página (Rosado bem claro/Off-white)
  static const Color backgroundColor = Color(0xFFFFF8F5);
  
  // Cores de Texto e Ícones
  static const Color textBlack = Color(0xFF231F20); // Preto suave
  static const Color textGrey = Color(0xFF757575);  // Cinza para legendas
  static const Color iconLight = Colors.white;      // Ícones sobre fundo colorido
  static const Color cardWhite = Colors.white;      // Fundo dos cards

  // --- ESTILOS DE TEXTO ---

  // Título principal (Ex: Gerenciar crianças)
  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textBlack,
    fontFamily: 'Inter', // Caso use essa fonte, senão o Flutter usa a padrão
  );

  // Seções (Ex: Crianças cadastradas)
  static const TextStyle sectionStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textBlack,
  );

  // Nome da criança no Card
  static const TextStyle cardTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: textBlack,
  );

  // Texto branco pequeno (Labels dentro dos badges de refeição/data)
  static const TextStyle lightLabelStyle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: iconLight,
  );

  // --- DIMENSÕES E ESPAÇAMENTOS ---
  
  static const double defaultPadding = 20.0;
  static const double cardPadding = 16.0;
  static const double elementSpacing = 15.0;
  
  // Arredondamento
  static const double borderRadius = 20.0;       // Para os Cards
  static const double buttonBorderRadius = 12.0; // Para os Botões
  static const double navBarRadius = 30.0;       // Para o topo da Nav Bar

  // --- ALTURAS ESPECÍFICAS ---
  static const double navBarHeight = 85.0;
  static const double centralButtonSize = 65.0;
}