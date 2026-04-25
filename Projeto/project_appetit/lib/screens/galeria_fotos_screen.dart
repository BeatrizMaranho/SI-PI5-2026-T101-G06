import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart'; // Importante para sua API

class GaleriaFotosScreen extends StatefulWidget {
  const GaleriaFotosScreen({super.key});

  @override
  State<GaleriaFotosScreen> createState() => _GaleriaFotosScreenState();
}

class _GaleriaFotosScreenState extends State<GaleriaFotosScreen> {
  final ImagePicker _picker = ImagePicker();
  
  // TROCAMOS: File? por XFile? para sua integração funcionar
  XFile? _fotoAntes;
  XFile? _fotoDepois;
  String _selectedChild = 'Sofia';
  bool _isAnalyzing = false; // Controle de loading

  static const Color backgroundColor = Color(0xFFFFF8F5);
  static const Color primaryOrange = Color(0xFFE35D33);
  static const Color borderOrange = Color(0xFFF7A082);

  Future<void> _escolherDaGaleria(bool isAntes) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          if (isAntes) {
            _fotoAntes = pickedFile;
          } else {
            _fotoDepois = pickedFile;
          }
        });
      }
    } catch (e) {
      debugPrint("Erro ao acessar a galeria: $e");
    }
  }

  // --- SUA LÓGICA DE INTEGRAÇÃO (Mesma da tela de câmera) ---
  Future<void> _enviarParaAnalise() async {
    if (_fotoAntes == null || _fotoDepois == null) return;
    
    setState(() => _isAnalyzing = true);
    try {
      final dio = Dio();
      
      // Lendo como bytes para funcionar em qualquer plataforma
      final bytesAntes = await _fotoAntes!.readAsBytes();
      final bytesDepois = await _fotoDepois!.readAsBytes();
      
      FormData formData = FormData.fromMap({
        "child": _selectedChild,
        "file_antes": MultipartFile.fromBytes(bytesAntes, filename: _fotoAntes!.name),
        "file_depois": MultipartFile.fromBytes(bytesDepois, filename: _fotoDepois!.name),
      });

      final response = await dio.post(
        "http://127.0.0.1:8000/analisar", 
        data: formData,
      );

      if (response.statusCode == 200) {
        _exibirResultado(response.data['analise']);
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
        title: Text("Resultado: $_selectedChild"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: dados.map((i) => Text("- ${i['item']} (${i['precisao']}%)")).toList(),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Fechar"))],
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text("Selecione a criança desejada", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            _buildDropdown(),
            const SizedBox(height: 25),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildGalleryCard(
                      label: "Escolher foto antes",
                      foto: _fotoAntes,
                      onTap: () => _escolherDaGaleria(true),
                      onRemove: () => setState(() => _fotoAntes = null),
                    ),
                    const SizedBox(height: 20),
                    _buildGalleryCard(
                      label: "Escolher foto depois",
                      foto: _fotoDepois,
                      onTap: () => _escolherDaGaleria(false),
                      onRemove: () => setState(() => _fotoDepois = null),
                    ),
                    const SizedBox(height: 25),
                    
                    // Botão com sua lógica de análise
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (_fotoAntes != null && _fotoDepois != null && !_isAnalyzing) 
                          ? _enviarParaAnalise 
                          : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryOrange,
                          disabledBackgroundColor: primaryOrange.withOpacity(0.5),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: _isAnalyzing 
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Analisar", style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 25),
                    _buildInfoCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- MÉTODOS DE UI (Exatamente como a amiga fez, mas usando XFile) ---

  Widget _buildDropdown() { /* Código do dropdown igual ao anterior */ return Container(); }

  Widget _buildGalleryCard({required String label, required XFile? foto, required VoidCallback onTap, required VoidCallback onRemove}) {
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
              child: SvgPicture.asset('assets/icons/upload.svg', width: 30, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
            ),
            const SizedBox(height: 12),
            Text(foto == null ? label : foto.name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            if (foto != null) IconButton(icon: const Icon(Icons.close, size: 18), onPressed: onRemove),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() { /* Código do info card igual ao anterior */ return Container(); }
}