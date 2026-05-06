import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_appetit/constants.dart'; 
import 'dart:io';
import 'package:project_appetit/service/api_service.dart';

// 🔥 Firebase
import 'package:firebase_auth/firebase_auth.dart';

class TirarFotosScreen extends StatefulWidget {
  final String nomeCrianca; 
  final String pacienteId;

  const TirarFotosScreen({
    super.key, 
    required this.nomeCrianca, 
    required this.pacienteId
  });

  @override
  State<TirarFotosScreen> createState() => _TirarFotosScreenState();
}

class _TirarFotosScreenState extends State<TirarFotosScreen> {
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
      // ✅ Firebase UID correto
      String? meuResponsavelId = FirebaseAuth.instance.currentUser?.uid;

      // 🔥 fallback
      meuResponsavelId ??= "1FeuJsPM0Cc63oAl1WmOhJmrqjD3";

      final dados = await ApiService.buscarPacientes(meuResponsavelId);

      if (mounted) {
        setState(() {
          _pacientesList = dados;

          // 🔥 garante que o selecionado existe
          if (_pacientesList.isNotEmpty) {
            final existe = _pacientesList.any((p) => p['id'] == _currentSelectedId);

            if (!existe) {
              _currentSelectedId = _pacientesList[0]['id'];
              _currentSelectedNome = _pacientesList[0]['nome'];
            }
          }

          _fetchingChildren = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _fetchingChildren = false);
      debugPrint("Erro ao carregar pacientes: $e");
    }
  }

  Future<void> _executarAnalise() async {
    if (_fotoAntes == null || _fotoDepois == null) return;

    setState(() => _loading = true);

    try {
      final resultado = await ApiService.enviarFotos(
        XFile(_fotoAntes!.path),
        XFile(_fotoDepois!.path),
        _currentSelectedNome ?? widget.nomeCrianca,
      );

      if (!mounted) return;

      setState(() => _loading = false);

      if (resultado != null) {
        _mostrarResultado(resultado);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Erro na análise. Verifique o backend."),
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
        title: Text(
          "Análise da $_currentSelectedNome",
          style: AppConstants.titleStyle,
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Itens consumidos:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Divider(),
              if (data['analise'] != null)
                ...(data['analise'] as List).map((res) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("• ${res['item']}"),
                          Text(
                            "${res['porcentagem_consumida']}%",
                            style: const TextStyle(
                              color: Color(0xFFF67B55),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("FECHAR"),
          ),
        ],
      ),
    );
  }

  Future<void> _tirarFoto(bool isAntes) async {
    try {
      final picked = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (picked != null) {
        setState(() {
          if (isAntes) {
            _fotoAntes = File(picked.path);
          } else {
            _fotoDepois = File(picked.path);
          }
        });
      }
    } catch (e) {
      debugPrint("Erro câmera: $e");
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
        centerTitle: true,
        title: const Text(
          "Registrar refeições",
          style: AppConstants.titleStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(height: 20),

            _buildDynamicDropdown(statsOrange),

            const SizedBox(height: 25),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildCaptureCard(
                      label: "Foto ANTES da refeição",
                      foto: _fotoAntes,
                      onTap: () => _tirarFoto(true),
                      onRemove: () => setState(() => _fotoAntes = null),
                      circleColor: statsOrange,
                    ),
                    const SizedBox(height: 20),

                    _buildCaptureCard(
                      label: "Foto DEPOIS da refeição",
                      foto: _fotoDepois,
                      onTap: () => _tirarFoto(false),
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
                                !_loading)
                            ? _executarAnalise
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: _loading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Analisar Consumo"),
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

  Widget _buildDynamicDropdown(Color color) {
    if (_fetchingChildren) {
      return const LinearProgressIndicator();
    }

    if (_pacientesList.isEmpty) {
      return const Text("Nenhuma criança encontrada");
    }

    return DropdownButton<String>(
      value: _currentSelectedId,
      isExpanded: true,
      items: _pacientesList.map<DropdownMenuItem<String>>((p) {
        return DropdownMenuItem<String>(
          value: p['id'].toString(),
          child: Text(p['nome']),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          _currentSelectedId = val;
          _currentSelectedNome =
              _pacientesList.firstWhere((p) => p['id'] == val)['nome'];
        });
      },
    );
  }

  Widget _buildCaptureCard({
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
        padding: const EdgeInsets.symmetric(vertical: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Icon(Icons.camera_alt, color: circleColor),
            const SizedBox(height: 10),
            Text(label),
            if (foto != null)
              const Text("Foto pronta", style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}