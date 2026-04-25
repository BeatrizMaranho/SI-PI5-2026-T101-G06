import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GaleriaFotosScreen extends StatefulWidget {
  const GaleriaFotosScreen({super.key});

  @override
  State<GaleriaFotosScreen> createState() => _GaleriaFotosScreenState();
}

class _GaleriaFotosScreenState extends State<GaleriaFotosScreen> {
  final ImagePicker _picker = ImagePicker();
  
  // Variáveis para armazenar os arquivos selecionados
  File? _fotoAntes;
  File? _fotoDepois;
  String _selectedChild = 'Sofia';

  // Constantes de Cores
  static const Color backgroundColor = Color(0xFFFFF8F5);
  static const Color primaryOrange = Color(0xFFE35D33);
  static const Color borderOrange = Color(0xFFF7A082);

  // ESTA É A LÓGICA QUE ABRE A GALERIA
  Future<void> _escolherDaGaleria(bool isAntes) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery, // Define que a origem é a galeria
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
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
                    // Card Foto ANTES (Chama a galeria)
                    _buildGalleryCard(
                      label: "Escolher foto antes da refeição",
                      foto: _fotoAntes,
                      onTap: () => _escolherDaGaleria(true),
                      onRemove: () => setState(() => _fotoAntes = null),
                    ),
                    const SizedBox(height: 20),
                    
                    // Card Foto DEPOIS (Chama a galeria)
                    _buildGalleryCard(
                      label: "Escolher foto depois da refeição",
                      foto: _fotoDepois,
                      onTap: () => _escolherDaGaleria(false),
                      onRemove: () => setState(() => _fotoDepois = null),
                    ),
                    const SizedBox(height: 25),

                    // Botão Analisar (Ativa apenas com as 2 fotos)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (_fotoAntes != null && _fotoDepois != null) ? () {
                          // Lógica para enviar as fotos ao modelo YOLO
                        } : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryOrange,
                          disabledBackgroundColor: primaryOrange.withOpacity(0.5),
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderOrange.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(color: borderOrange, shape: BoxShape.circle),
              child: SvgPicture.asset(
                'assets/icons/upload.svg', 
                width: 30, 
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)
              ),
            ),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            
            if (foto != null) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      foto.path.split('/').last,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onRemove,
                    child: const Icon(Icons.close, size: 18, color: Colors.black54),
                  ),
                ],
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
        color: backgroundColor,
        border: Border.all(color: borderOrange.withOpacity(0.5)),
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