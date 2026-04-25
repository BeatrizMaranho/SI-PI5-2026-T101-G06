import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; 
import 'package:image_picker/image_picker.dart';
// REMOVEMOS o import 'dart:io'; para evitar conflitos na Web

class UploadPhotosScreen extends StatefulWidget {
  const UploadPhotosScreen({super.key});

  @override
  State<UploadPhotosScreen> createState() => _UploadPhotosScreenState();
}

class _UploadPhotosScreenState extends State<UploadPhotosScreen> {
  // MUDANÇA: Usamos XFile em vez de File para funcionar no Edge/Web
  final List<XFile> _selectedImages = []; 
  final ImagePicker _picker = ImagePicker();
  String _selectedChild = 'Sofia';
  bool _isAnalyzing = false;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(pickedFile); // Adiciona o XFile diretamente
      });
    }
  }

  Future<void> _enviarParaAnalise() async {
    if (_selectedImages.isEmpty) return;

    setState(() => _isAnalyzing = true);

    try {
      final dio = Dio();
      final imageXFile = _selectedImages.first;

      // Lendo os bytes de forma compatível com a Web
      final bytes = await imageXFile.readAsBytes();
      
      FormData formData = FormData.fromMap({
        "file": MultipartFile.fromBytes(
          bytes,
          filename: imageXFile.name,
        ),
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
      appBar: AppBar(
        title: const Text("Registrar refeições", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Selecione a criança desejada", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            _buildDropdown(),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: _selectedImages.isEmpty ? _buildInitialSelection() : _buildPhotoList(),
              ),
            ),
            if (_selectedImages.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isAnalyzing ? null : _enviarParaAnalise,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE35D33),
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

  // --- MÉTODOS AUXILIARES REVISADOS ---

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFF7A082)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedChild,
          isExpanded: true,
          items: ['Sofia', 'João', 'Maria'].map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (val) => setState(() => _selectedChild = val!),
        ),
      ),
    );
  }

  Widget _buildInitialSelection() {
    return Column(
      children: [
        const Text("Como deseja adicionar a foto?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 12),
        _buildInstructionCard(),
        const SizedBox(height: 16),
        _buildOptionCard(
          icon: Icons.camera_alt_outlined,
          label: "Tirar foto agora",
          onTap: () => _pickImage(ImageSource.camera),
        ),
        const SizedBox(height: 16),
        _buildOptionCard(
          icon: Icons.image_outlined,
          label: "Escolher da galeria",
          onTap: () => _pickImage(ImageSource.gallery),
        ),
      ],
    );
  }

  Widget _buildInstructionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFF7A082)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        children: [
          Icon(Icons.apple, color: Colors.black54, size: 30), 
          SizedBox(height: 8),
          Text(
            "Tire uma foto ou envie uma imagem da refeição.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFF7A082)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFF7A082),
              radius: 30,
              child: Icon(icon, color: Colors.white, size: 30),
            ),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
        border: Border.all(color: const Color(0xFFF7A082)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          IconButton(
            icon: const Icon(Icons.add_a_photo, color: Color(0xFFF7A082), size: 40),
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