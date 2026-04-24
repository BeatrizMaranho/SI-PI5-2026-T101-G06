import 'package:flutter/material.dart';
// Removido o import do bottom_nav_bar pois esta tela não o utiliza
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadPhotosScreen extends StatefulWidget {
  const UploadPhotosScreen({super.key});

  @override
  State<UploadPhotosScreen> createState() => _UploadPhotosScreenState();
}

class _UploadPhotosScreenState extends State<UploadPhotosScreen> {
  final List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  String _selectedChild = 'Sofia';

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // O BackButton vai funcionar pois está usando Navigator.push
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Registrar refeições", 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Selecione a criança desejada", 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
            ),
            const SizedBox(height: 8),
            _buildDropdown(),
            const SizedBox(height: 24),
            
            // Lógica de exibição de fotos ou opções de seleção
            Expanded( // Adicionado para evitar overflow se a lista crescer
              child: SingleChildScrollView(
                child: _selectedImages.isEmpty 
                    ? _buildInitialSelection() 
                    : _buildPhotoList(),
              ),
            ),
            
            if (_selectedImages.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () { 
                      // Aqui vai integrar com o modelo YOLO do Select Food depois
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE35D33),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Analisar", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Métodos auxiliares (_buildDropdown, _buildInitialSelection, etc.) 
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
        const Text(
          "Como deseja adicionar a foto?",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        _buildInstructionCard(), // card com ícone de maça
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
      child: Column(
        children: [
          // ÍCONE DA MAÇÃ (Você pode usar um Icon de comida ou uma imagem)
          const Icon(Icons.apple, color: Colors.black54, size: 30), 
          const SizedBox(height: 8),
          const Text(
            "Tire uma foto ou envie uma imagem da refeição. Você pode adicionar várias fotos para uma mesma refeição!",
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
          ..._selectedImages.map((file) => ListTile(
            leading: const Icon(Icons.image, color: Colors.grey),
            title: Text(file.path.split('/').last, style: const TextStyle(fontSize: 14)),
            trailing: IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: () => setState(() => _selectedImages.remove(file)),
            ),
          )),
        ],
      ),
    );
  }
}