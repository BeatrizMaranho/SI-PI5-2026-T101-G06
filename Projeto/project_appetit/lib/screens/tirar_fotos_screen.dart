import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TirarFotosScreen extends StatefulWidget {
  const TirarFotosScreen({super.key});

  @override
  State<TirarFotosScreen> createState() => _TirarFotosScreenState();
}

class _TirarFotosScreenState extends State<TirarFotosScreen> {
  final ImagePicker _picker = ImagePicker();
  
  // Variáveis para armazenar as fotos capturadas
  File? _fotoAntes;
  File? _fotoDepois;
  String _selectedChild = 'Sofia';

  // Constantes de Cores
  static const Color backgroundColor = Color(0xFFFFF8F5);
  static const Color primaryOrange = Color(0xFFE35D33);
  static const Color borderOrange = Color(0xFFF7A082);

  // Lógica para abrir a câmera e salvar a foto
  Future<void> _tirarFoto(bool isAntes) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85, // Otimiza o tamanho da imagem para o processamento posterior
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
      // Caso ocorra erro de permissão ou hardware
      debugPrint("Erro ao abrir a câmera: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao acessar a câmera. Verifique as permissões nas configurações.")),
      );
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
                    // Card Foto ANTES
                    _buildCaptureCard(
                      label: "Tirar foto antes da refeição",
                      foto: _fotoAntes,
                      onTap: () => _tirarFoto(true),
                      onRemove: () => setState(() => _fotoAntes = null),
                    ),
                    const SizedBox(height: 20),
                    
                    // Card Foto DEPOIS
                    _buildCaptureCard(
                      label: "Tirar foto depois da refeição",
                      foto: _fotoDepois,
                      onTap: () => _tirarFoto(false),
                      onRemove: () => setState(() => _fotoDepois = null),
                    ),
                    const SizedBox(height: 25),

                    // Botão Analisar (Habilitado apenas com as duas fotos)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (_fotoAntes != null && _fotoDepois != null) ? () {
                          // Aqui você integrará o envio dos arquivos para o YOLO
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

                    // Card Informativo do Limão
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

  Widget _buildCaptureCard({
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
                'assets/icons/camera.svg', 
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