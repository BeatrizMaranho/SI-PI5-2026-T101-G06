import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_appetit/constants.dart'; 
import 'dart:io';
import 'package:project_appetit/service/api_service.dart';

// 🔥 Firebase (NOVO)
import 'package:firebase_auth/firebase_auth.dart';

class GaleriaFotosScreen extends StatefulWidget {
  final String nomeCrianca; 
  final String pacienteId;

  const GaleriaFotosScreen({
    super.key, 
    required this.nomeCrianca, 
    required this.pacienteId
  });

  @override
  State<GaleriaFotosScreen> createState() => _GaleriaFotosScreenState();
}

class _GaleriaFotosScreenState extends State<GaleriaFotosScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _loading = false;
  bool _fetchingChildren = true;
  File? _fotoAntes;
  File? _fotoDepois;

  List<Map<String, dynamic>> _pacientesList = [];
  String? _currentSelectedId;
  String? _currentSelectedNome;

  @override
  void initState() {
    super.initState();
    _currentSelectedId = widget.pacienteId;
    _currentSelectedNome = widget.nomeCrianca;
    _fetchMyChildren(); 
  }

  Future<void> _fetchMyChildren() async {
    try {
      // ✅ PEGA UID REAL (corrige problema de pegar criança errada)
      String? meuResponsavelId = FirebaseAuth.instance.currentUser?.uid;

      // 🔥 fallback com ID correto (COM ZERO, não letra O)
      meuResponsavelId ??= "l6T5V8ODQZdTnnLI55BrNF2QhH02";

      //print("UID usado: $meuResponsavelId");

      final List<Map<String, dynamic>> dadosDoBanco =
          await ApiService.buscarPacientes(meuResponsavelId);

      if (mounted) {
        setState(() {
          _pacientesList = dadosDoBanco;

          if (_pacientesList.isNotEmpty && _currentSelectedId == null) {
            _currentSelectedId = _pacientesList[0]['id'];
            _currentSelectedNome = _pacientesList[0]['nome'];
          }

          _fetchingChildren = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _fetchingChildren = false);
      }
      debugPrint("Erro ao carregar lista: $e");
    }
  }

  Future<void> _executarAnalise() async {
    if (_fotoAntes == null || _fotoDepois == null) return;

    setState(() => _loading = true);

    try {
      final resultado = await ApiService.enviarFotos(
        XFile(_fotoAntes!.path), 
        XFile(_fotoDepois!.path),
        _currentSelectedNome ?? widget.nomeCrianca 
      );

      if (!mounted) return;
      setState(() => _loading = false);

      if (resultado != null) {
        _mostrarResultado(resultado);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Erro ao processar imagens. Verifique se o backend está rodando."),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      if (mounted) setState(() => _loading = false);
      debugPrint("Erro na análise: $e");
    }
  }

  void _mostrarResultado(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text("Análise da $_currentSelectedNome", style: AppConstants.titleStyle),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Detalhamento por item:", style: TextStyle(fontWeight: FontWeight.bold)),
              const Divider(),
              if (data['analise'] != null)
                ...(data['analise'] as List).map((info) {
                  final double porc = info['porcentagem_consumida'].toDouble();
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("• ${info['item']}:", style: const TextStyle(fontWeight: FontWeight.w500)),
                        Text("${porc.toStringAsFixed(1)}%", 
                          style: TextStyle(
                            color: porc > 50 ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.bold
                          )),
                      ],
                    ),
                  );
                }),
              const Divider(),
              const SizedBox(height: 10),
              if (data['detalhes'] != null && data['detalhes']['consumido'] != null)
                Text(
                  "Consumido: ${data['detalhes']['consumido'].join(', ')}",
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("FECHAR", style: TextStyle(color: Color(0xFFE35D33), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Future<void> _escolherDaGaleria(bool isAntes) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          if (isAntes) _fotoAntes = File(pickedFile.path);
          else _fotoDepois = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint("Erro ao acessar a galeria: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color statsOrange = Color(0xFFF67B55);
    const Color primaryOrange = Color(0xFFE35D33);

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text("Registrar refeições", style: AppConstants.titleStyle),
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
            
            _buildDynamicDropdown(statsOrange),
            
            const SizedBox(height: 25),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildGalleryCard(
                      label: "Foto ANTES da refeição",
                      foto: _fotoAntes,
                      onTap: () => _escolherDaGaleria(true),
                      onRemove: () => setState(() => _fotoAntes = null),
                      circleColor: statsOrange,
                    ),
                    const SizedBox(height: 20),
                    
                    _buildGalleryCard(
                      label: "Foto DEPOIS da refeição",
                      foto: _fotoDepois,
                      onTap: () => _escolherDaGaleria(false),
                      onRemove: () => setState(() => _fotoDepois = null),
                      circleColor: statsOrange,
                    ),
                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: (_fotoAntes != null && 
                                    _fotoDepois != null && 
                                    _currentSelectedId != null && 
                                    !_loading) 
                          ? _executarAnalise 
                          : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryOrange,
                          disabledBackgroundColor: Colors.grey.shade400,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 0,
                        ),
                        child: _loading 
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text("Analisar Consumo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
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

  Widget _buildDynamicDropdown(Color orangeColor) {
    if (_fetchingChildren) {
      return const Center(child: LinearProgressIndicator(color: Color(0xFFF67B55)));
    }

    if (_pacientesList.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
        ),
        child: const Text(
          "⚠️ Nenhuma criança encontrada no banco.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: orangeColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _currentSelectedId,
          isExpanded: true,
          dropdownColor: Colors.white,
          items: _pacientesList.map((paciente) {
            return DropdownMenuItem<String>(
              value: paciente['id'], 
              child: Text(paciente['nome'], style: const TextStyle(fontSize: 16, color: Colors.black))
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              _currentSelectedId = val;
              _currentSelectedNome = _pacientesList.firstWhere((p) => p['id'] == val)['nome'];
            });
          },
        ),
      ),
    );
  }

  Widget _buildGalleryCard({
    required String label, 
    required File? foto, 
    required VoidCallback onTap,
    required VoidCallback onRemove,
    required Color circleColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: circleColor.withOpacity(0.2), width: 1.2),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 60, width: 60,
              decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
              child: const Center(
                child: Icon(Icons.upload_file_rounded, color: Colors.white, size: 30),
              ),
            ),
            const SizedBox(height: 15),
            Text(label, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            if (foto != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 18),
                    const SizedBox(width: 8),
                    const Text("Selecionada", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: onRemove,
                      child: const Icon(Icons.close, color: Colors.red, size: 18),
                    )
                  ],
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity, 
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF67B55).withOpacity(0.05), 
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF67B55).withOpacity(0.2)),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline, color: Color(0xFFF67B55), size: 24),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              "Escolha fotos nítidas para que o YOLO consiga identificar os alimentos corretamente.", 
              style: TextStyle(fontSize: 12, color: Colors.black87, height: 1.4)
            ),
          ),
        ],
      ),
    );
  }
}