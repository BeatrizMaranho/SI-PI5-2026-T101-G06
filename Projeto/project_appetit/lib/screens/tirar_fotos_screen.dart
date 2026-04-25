import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:project_appetit/constants.dart'; // Importante para as cores

class TirarFotosScreen extends StatefulWidget {
  const TirarFotosScreen({super.key});

  @override
  State<TirarFotosScreen> createState() => _TirarFotosScreenState();
}

class _TirarFotosScreenState extends State<TirarFotosScreen> {
  final ImagePicker _picker = ImagePicker();
  
  // Usando XFile para manter compatibilidade com sua lógica de API
  XFile? _fotoAntes;
  XFile? _fotoDepois;
  String _selectedChild = 'Sofia';
  bool _isAnalyzing = false;

  Future<void> _tirarFoto(bool isAntes) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
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
      debugPrint("Erro ao abrir a câmera: $e");
    }
  }

  // --- SUA LÓGICA DE INTEGRAÇÃO DE OURO ---
  Future<void> _enviarParaAnalise() async {
    if (_fotoAntes == null || _fotoDepois == null) return;
    
    setState(() => _isAnalyzing = true);
    try {
      final dio = Dio();
      
      // Lógica de bytes para evitar erro de Namespace na Web/Mobile
      final bytesAntes = await _fotoAntes!.readAsBytes();
      final bytesDepois = await _fotoDepois!.readAsBytes();
      
      FormData formData = FormData.fromMap({
        "child": _selectedChild,
        "file_antes": MultipartFile.fromBytes(bytesAntes, filename: _fotoAntes!.name),
        "file_depois": MultipartFile.fromBytes(bytesDepois, filename: _fotoDepois!.name),
      });

      final response = await dio.post(
        "http://127.0.0.1:8000/analisar", // Ajuste para o IP do seu servidor se necessário
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
        title: Text("Análise da $_selectedChild"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: dados.map((i) => ListTile(
              leading: const Icon(Icons.restaurant, color: AppConstants.primaryOrange),
              title: Text("${i['item']}"),
              subtitle: Text("Consumo: ${i['percentual']}%"),
            )).toList(),
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColor,
        elevation: 0,
        title: const Text("Registrar refeições", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildDropdown(),
            const SizedBox(height: 25),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildCaptureCard(
                      label: "Tirar foto antes",
                      foto: _fotoAntes,
                      onTap: () => _tirarFoto(true),
                      onRemove: () => setState(() => _fotoAntes = null),
                    ),
                    const SizedBox(height: 20),
                    _buildCaptureCard(
                      label: "Tirar foto depois",
                      foto: _fotoDepois,
                      onTap: () => _tirarFoto(false),
                      onRemove: () => setState(() => _fotoDepois = null),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (_fotoAntes != null && _fotoDepois != null && !_isAnalyzing) 
                            ? _enviarParaAnalise 
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.primaryOrange,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: _isAnalyzing 
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Analisar", style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widgets auxiliares de UI da sua amiga...
  Widget _buildDropdown() { /* Seu código de dropdown aqui */ return const SizedBox(); }
  Widget _buildCaptureCard({required String label, required XFile? foto, required VoidCallback onTap, required VoidCallback onRemove}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppConstants.backgroundColor,
          border: Border.all(color: AppConstants.primaryOrange.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            const Icon(Icons.camera_alt, size: 40, color: AppConstants.primaryOrange),
            const SizedBox(height: 10),
            Text(foto == null ? label : foto.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            if (foto != null) IconButton(icon: const Icon(Icons.close), onPressed: onRemove)
          ],
        ),
      ),
    );
  }
}