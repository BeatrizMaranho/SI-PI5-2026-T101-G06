import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_appetit/constants.dart'; // Importando suas constantes
import 'dart:io';

class GaleriaFotosScreen extends StatefulWidget {
  const GaleriaFotosScreen({super.key});

  @override
  State<GaleriaFotosScreen> createState() => _GaleriaFotosScreenState();
}

class _GaleriaFotosScreenState extends State<GaleriaFotosScreen> {
  final ImagePicker _picker = ImagePicker();
  
  File? _fotoAntes;
  File? _fotoDepois;
  String _selectedChild = 'Sofia';

  Future<void> _escolherDaGaleria(bool isAntes) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          if (isAntes) {
            _fotoAntes = File(pickedFile.path);
          } else {
            _fotoDepois = File(pickedFile.path);
          }
        });
      }
    } catch (e) {
      debugPrint("Erro ao acessar a galeria: $e");
    }
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Selecione a criança desejada",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),
            _buildDropdown(),
            const SizedBox(height: 25),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildGalleryCard(
                      label: "Escolher foto antes da refeição",
                      foto: _fotoAntes,
                      onTap: () => _escolherDaGaleria(true),
                      onRemove: () => setState(() => _fotoAntes = null),
                    ),
                    const SizedBox(height: 20),
                    
                    _buildGalleryCard(
                      label: "Escolher foto depois da refeição",
                      foto: _fotoDepois,
                      onTap: () => _escolherDaGaleria(false),
                      onRemove: () => setState(() => _fotoDepois = null),
                    ),
                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (_fotoAntes != null && _fotoDepois != null) ? () {
                          // Lógica para enviar as fotos ao YOLO
                        } : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.primaryOrange,
                          disabledBackgroundColor: AppConstants.primaryOrange.withOpacity(0.5),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text(
                          "Analisar",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    _buildInfoCard(),
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

  Widget _buildGalleryCard({
    required String label, 
    required File? foto, 
    required VoidCallback onTap,
    required VoidCallback onRemove,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        decoration: BoxDecoration(
          color: AppConstants.backgroundColor,
          border: Border.all(
            color: AppConstants.borderOrange.withOpacity(0.3), 
            width: 1.2
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            // CÍRCULO COM A COR PADRONIZADA (0xF67B55) - CORRIGIDO COM TAMANHO FIXO
            Container(
              height: 70, // Altura fixa para não sumir no Chrome
              width: 70,  // Largura fixa para não sumir no Chrome
              decoration: const BoxDecoration(
                color: Color(0xFFF67B55), // Forçando opacidade total
                shape: BoxShape.circle
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/upload.svg', 
                  width: 35, 
                  height: 35,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              label, 
              style: const TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.w600,
                color: Colors.black
              )
            ),
            
            if (foto != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppConstants.borderOrange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        foto.path.split('/').last,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7), 
                          fontSize: 13,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: onRemove,
                      child: const Icon(Icons.cancel, size: 20, color: Colors.redAccent),
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
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
          SvgPicture.asset('assets/icons/limao.svg', width: 30),
          const SizedBox(height: 12),
          const Text(
            "As fotos ficam salvas mesmo se você sair. Você pode completar as informações da refeição depois!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
          ),
        ],
      ),
    );
  }
}