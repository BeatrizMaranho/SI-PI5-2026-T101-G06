import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Importando as telas de destino
import 'package:project_appetit/screens/tirar_fotos_screen.dart'; 
import 'package:project_appetit/screens/galeria_fotos_screen.dart';

class UploadPhotosScreen extends StatefulWidget {
  const UploadPhotosScreen({super.key});

  @override
  State<UploadPhotosScreen> createState() => _UploadPhotosScreenState();
}

class _UploadPhotosScreenState extends State<UploadPhotosScreen> {
  // Cores da identidade visual do Select Food
  static const Color backgroundColor = Color(0xFFFFF8F5);
  static const Color primaryOrange = Color(0xFFE35D33); 
  static const Color borderOrange = Color(0xFFF7A082);

  String _selectedChild = 'Sofia'; // Estado para o dropdown

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Registrar refeições",
          style: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.bold, 
            fontSize: 20
          ),
        ),
      ),
      body: SingleChildScrollView( // Para evitar erro de overflow em telas menores
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Selecione a criança desejada",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            
            // DROPDOWN DE SELEÇÃO
            _buildChildDropdown(),
            
            const SizedBox(height: 25),
            
            // NOVO CARD DE INSTRUÇÃO (Com ícone de maçã do layout novo)
            _buildInstructionCardWithApple(),
            
            const SizedBox(height: 25),
            
            // CARD 1: Câmera
            _buildOptionCard(
              icon: Icons.camera_alt_rounded,
              label: "Tirar foto agora",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TirarFotosScreen()),
                );
              },
            ),
            
            const SizedBox(height: 15),
            
            // CARD 2: Galeria
            _buildOptionCard(
              icon: Icons.image_rounded, 
              label: "Escolher da galeria",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GaleriaFotosScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- COMPONENTES DE UI ---

  Widget _buildChildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderOrange.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedChild,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
          items: ['Sofia', 'João', 'Maria'].map((String value) {
            return DropdownMenuItem<String>(
              value: value, 
              child: Text(value, style: const TextStyle(color: Colors.black87))
            );
          }).toList(),
          onChanged: (val) => setState(() => _selectedChild = val!),
        ),
      ),
    );
  }

  Widget _buildInstructionCardWithApple() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2).withOpacity(0.5), // Cinza claro do print
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          const Icon(Icons.apple_rounded, size: 40, color: Colors.black54), // Ícone de maçã
          const SizedBox(height: 12),
          const Text(
            "Tire uma foto ou envie uma imagem da refeição.\nVocê pode adicionar várias fotos para uma mesma refeição!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13, 
              color: Colors.black54,
              height: 1.5
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon, 
    required String label, 
    required VoidCallback onTap
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 25),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2).withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: primaryOrange.withOpacity(0.2),
              child: Icon(icon, color: primaryOrange, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              label, 
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w600,
                color: Colors.black87
              )
            ),
          ],
        ),
      ),
    );
  }
}