import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_appetit/constants.dart'; // Importante para as cores
import 'package:project_appetit/screens/tirar_fotos_screen.dart'; 
import 'package:project_appetit/screens/galeria_fotos_screen.dart'; 

class UploadPhotosScreen extends StatefulWidget {
  const UploadPhotosScreen({super.key});

  @override
  State<UploadPhotosScreen> createState() => _UploadPhotosScreenState();
}

class _UploadPhotosScreenState extends State<UploadPhotosScreen> {
  String _selectedChild = 'Sofia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/back.svg', width: 24),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Registrar refeições",
          style: AppConstants.titleStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Selecione a criança desejada",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 10),
            
            _buildChildDropdown(),
            
            const SizedBox(height: 30),
            const Text(
              "Como deseja adicionar a foto?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildInstructionCard(),
                    const SizedBox(height: 20),
                    
                    // BOTÃO: TIRAR FOTO AGORA
                    _buildOptionCard(
                      svgPath: 'assets/icons/camera.svg', // Voltamos para o SVG
                      label: "Tirar foto agora",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TirarFotosScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    
                    // BOTÃO: ESCOLHER DA GALERIA
                    _buildOptionCard(
                      svgPath: 'assets/icons/upload.svg', // Voltamos para o SVG
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor,
        border: Border.all(color: AppConstants.borderOrange),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedChild,
          isExpanded: true,
          dropdownColor: AppConstants.backgroundColor,
          icon: SvgPicture.asset(
            'assets/icons/down.svg',
            width: 12,
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          items: ['Sofia', 'João', 'Maria'].map((String value) {
            return DropdownMenuItem<String>(
              value: value, 
              child: Text(value, style: const TextStyle(fontSize: 16, color: Colors.black))
            );
          }).toList(),
          onChanged: (val) => setState(() => _selectedChild = val!),
        ),
      ),
    );
  }

  Widget _buildInstructionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor,
        border: Border.all(color: AppConstants.borderOrange.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SvgPicture.asset('assets/icons/apple.svg', width: 30),
          const SizedBox(height: 12),
          const Text(
            "Tire uma foto ou envie uma imagem da refeição. Você pode adicionar várias fotos para uma mesma refeição!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
  required String svgPath, 
  required String label, 
  required VoidCallback onTap
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor, // 0xFFFFF8F5
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppConstants.borderOrange.withOpacity(0.3), 
          width: 1.2,
        ),
      ),
      child: Column(
        children: [
          // ESTE CONTAINER É O CÍRCULO LARANJA
          Container(
            height: 70, // Altura fixa garante que ele não colapse
            width: 70,  // Largura fixa
            decoration: const BoxDecoration(
              color: Color(0xFFF67B55), // Usei o prefixo 0xFF para garantir opacidade total
              shape: BoxShape.circle,
            ),
            // O Center garante que o ícone fique exatamente no meio
            child: Center(
              child: SvgPicture.asset(
                svgPath,
                width: 35,
                height: 35,
                colorFilter: const ColorFilter.mode(
                  Colors.white, 
                  BlendMode.srcIn
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
  }
}