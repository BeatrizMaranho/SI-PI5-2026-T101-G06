import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; 
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
// REMOVEMOS o import 'dart:io'; para evitar conflitos na Web

class UploadPhotosScreen extends StatefulWidget {
  const UploadPhotosScreen({super.key});

  @override
  State<UploadPhotosScreen> createState() => _UploadPhotosScreenState();
}

class _UploadPhotosScreenState extends State<UploadPhotosScreen> {
  // LÓGICA DA ANA (Mantida para a API funcionar)
  final List<XFile> _selectedImages = []; 
  final ImagePicker _picker = ImagePicker();
  String _selectedChild = 'Sofia';
  bool _isAnalyzing = false;

  // LAYOUT DA AMIGA (Cores e estilos)
  static const Color backgroundColor = Color(0xFFFFF8F5);
  static const Color primaryOrange = Color(0xFFE35D33); 
  static const Color borderOrange = Color(0xFFF7A082);

  // Função para pegar imagem (Sua lógica necessária para alimentar a lista)
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(pickedFile);
      });
    }
  }

  // INTEGRAÇÃO COM API (Sua lógica de ouro)
  Future<void> _enviarParaAnalise() async {
    if (_selectedImages.isEmpty) return;
    setState(() => _isAnalyzing = true);
    try {
      final dio = Dio();
      final imageXFile = _selectedImages.first;
      final bytes = await imageXFile.readAsBytes();
      
      FormData formData = FormData.fromMap({
        "file": MultipartFile.fromBytes(bytes, filename: imageXFile.name),
      });

      final response = await dio.post(
        "http://127.0.0.1:8000/analisar",
        data: formData,
      );

      if (response.statusCode == 200) {
        final analise = response.data['analise'] as List;
        _exibirResultado(analise);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro na conexão: $e")),
      );
    } finally {
      setState(() => _isAnalyzing = false);
    }
  }

  void _exibirResultado(List dados) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Resultado para $_selectedChild"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: dados.isEmpty 
            ? [const Text("Nenhum item identificado.")]
            : dados.map((i) => ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: Text("${i['item']}"),
                subtitle: Text("Precisão: ${i['precisao']}%"),
              )).toList(),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
        ],
      ),
    );
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
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildInstructionCard(),
                    const SizedBox(height: 20),
                    
                    // Se não houver fotos, mostra as opções de adicionar
                    if (_selectedImages.isEmpty) ...[
                      _buildOptionCard(
                        svgIcon: 'camera.svg',
                        label: "Tirar foto agora",
                        onTap: () => _pickImage(ImageSource.camera),
                      ),
                      const SizedBox(height: 20),
                      _buildOptionCard(
                        svgIcon: 'upload.svg', 
                        label: "Escolher da galeria",
                        onTap: () => _pickImage(ImageSource.gallery),
                      ),
                    ] else ...[
                      // Se houver fotos, mostra a lista que você criou
                      _buildPhotoList(),
                    ],
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Botão de Analisar (Sua lógica de integração)
            if (_selectedImages.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isAnalyzing ? null : _enviarParaAnalise,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryOrange,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isAnalyzing 
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text("Analisar", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // --- MÉTODOS AUXILIARES ---

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderOrange),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedChild,
          isExpanded: true,
          dropdownColor: backgroundColor,
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
            Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoList() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderOrange),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          IconButton(
            icon: const Icon(Icons.add_a_photo, color: borderOrange, size: 40),
            onPressed: () => _pickImage(ImageSource.camera),
          ),
          ..._selectedImages.map((xFile) => ListTile(
            leading: const Icon(Icons.image, color: Colors.grey),
            title: Text(xFile.name, style: const TextStyle(fontSize: 14)),
            trailing: IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: () => setState(() => _selectedImages.remove(xFile)),
            ),
          )),
        ],
      ),
    );
  }
}