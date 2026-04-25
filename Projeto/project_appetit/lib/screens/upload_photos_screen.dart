import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_appetit/screens/tirar_fotos_screen.dart'; // Importe suas novas telas
import 'package:project_appetit/screens/galeria_fotos_screen.dart'; 

class UploadPhotosScreen extends StatefulWidget {
  const UploadPhotosScreen({super.key});

  @override
  State<UploadPhotosScreen> createState() => _UploadPhotosScreenState();
}

class _UploadPhotosScreenState extends State<UploadPhotosScreen> {
  String _selectedChild = 'Sofia';

  // Constantes de cores mantidas para o layout
  static const Color backgroundColor = Color(0xFFFFF8F5);
  static const Color primaryOrange = Color(0xFFE35D33); 
  static const Color borderOrange = Color(0xFFF7A082);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          // Note: Verifique se o nome é back.svg ou bacn.svg como mencionado antes
          icon: SvgPicture.asset('assets/icons/back.svg', width: 24),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Registrar refeições",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
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
            _buildDropdown(),
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
                      svgIcon: 'camera.svg',
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
                      svgIcon: 'upload.svg', 
                      label: "Escolher da galeria",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GaleriaFotosScreen()),
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

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor, // Mantendo o fundo que você pediu
        border: Border.all(color: borderOrange),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedChild,
          isExpanded: true,
          dropdownColor: backgroundColor,
          // AQUI ESTÁ A LÓGICA DO ÍCONE PERSONALIZADO:
          icon: SvgPicture.asset(
            'assets/icons/down.svg',
            width: 12, // Ajuste o tamanho conforme seu protótipo
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          items: ['Sofia', 'João', 'Maria'].map((String value) {
            return DropdownMenuItem<String>(
              value: value, 
              child: Text(
                value, 
                style: const TextStyle(fontSize: 16, color: Colors.black)
              )
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
        color: backgroundColor,
        border: Border.all(color: borderOrange.withOpacity(0.5)),
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

  Widget _buildOptionCard({required String svgIcon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 25),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderOrange.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: borderOrange,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/icons/$svgIcon',
                width: 35,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}