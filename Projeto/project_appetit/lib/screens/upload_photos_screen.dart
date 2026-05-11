import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_appetit/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as dev;
import 'package:project_appetit/dataconnect_generated/generated.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:project_appetit/service/api_service.dart';

class UploadPhotosScreen extends StatefulWidget {
  const UploadPhotosScreen({super.key});

  @override
  State<UploadPhotosScreen> createState() => _UploadPhotosScreenState();
}

class _UploadPhotosScreenState extends State<UploadPhotosScreen> {
  List<Map<String, dynamic>> _pacientes = [];
  String? _selectedChildId;
  String _selectedChildNome = '';
  bool _isLoading = true;
  bool _loadingAnalysis = false;

  // Lógica de "Antes" e "Depois" recuperada da tela antiga
  File? _fotoAntes;
  File? _fotoDepois;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchPacientes();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _verificarArgumentos();
    });
  }

  void _verificarArgumentos() {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

    if (args != null && args.containsKey('selectedChildId')) {
      final childId = args['selectedChildId'];
      final childName = args['selectedChildName'] ?? '';

      setState(() {
        _selectedChildId = childId;
        _selectedChildNome = childName;
      });

      dev.log(
        'Criança selecionada via argumentos: $childName (ID: $childId)',
        name: 'UPLOAD_PHOTOS',
      );
    }
  }

  Future<void> _fetchPacientes() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        dev.log("Usuário não logado", name: 'UPLOAD_PHOTOS');
        setState(() => _isLoading = false);
        return;
      }

      final String meuResponsavelId = user.uid;

      dev.log("UID LOGADO: $meuResponsavelId", name: 'UPLOAD_PHOTOS');

      final resultado = await ExampleConnector.instance
          .listarMeusPacientes(responsavelId: meuResponsavelId)
          .execute();

      final List<Map<String, dynamic>> dadosDoBanco = resultado.data.pacientes
          .map((p) => {'id': p.id, 'nome': p.nome, 'nascimento': p.nascimento})
          .toList();

      dev.log(
        "Pacientes encontrados: ${dadosDoBanco.length}",
        name: 'UPLOAD_PHOTOS',
      );

      if (mounted) {
        setState(() {
          _pacientes = dadosDoBanco;

          if (_selectedChildId == null && _pacientes.isNotEmpty) {
            _selectedChildId = _pacientes[0]['id'];
            _selectedChildNome = _pacientes[0]['nome'];
            dev.log(
              "Primeiro paciente selecionado: $_selectedChildNome",
              name: 'UPLOAD_PHOTOS',
            );
          }

          _isLoading = false;
        });
      }
    } catch (e) {
      dev.log(
        "Erro ao carregar pacientes: $e",
        name: 'UPLOAD_PHOTOS',
        error: e,
      );
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _mostrarAvisoSemCrianca() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Nenhuma criança selecionada. Selecione uma criança primeiro.',
        ),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _abrirOpcoesMidia(bool isAntes) {
    if (_selectedChildId == null) {
      _mostrarAvisoSemCrianca();
      return;
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Adicionar foto",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFFF67B55)),
                title: const Text('Tirar foto agora'),
                onTap: () {
                  Navigator.of(context).pop();
                  _capturarMedia(isAntes, ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: Color(0xFFF67B55),
                ),
                title: const Text('Escolher da galeria'),
                onTap: () {
                  Navigator.of(context).pop();
                  _capturarMedia(isAntes, ImageSource.gallery);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Future<void> _capturarMedia(bool isAntes, ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
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
        dev.log("Mídia capturada: ${picked.path}", name: 'UPLOAD_PHOTOS');
      }
    } catch (e) {
      dev.log("Erro ao capturar mídia: $e", name: 'UPLOAD_PHOTOS', error: e);
    }
  }

  Future<void> _executarAnalise() async {
    if (_fotoAntes == null || _fotoDepois == null) return;

    setState(() => _loadingAnalysis = true);

    try {
      final resultado = await ApiService.enviarFotos(
        XFile(_fotoAntes!.path),
        XFile(_fotoDepois!.path),
        _selectedChildNome,
      );

      if (!mounted) return;

      setState(() => _loadingAnalysis = false);

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
      if (mounted) setState(() => _loadingAnalysis = false);
      dev.log("Erro na análise: $e", name: 'UPLOAD_PHOTOS', error: e);
    }
  }

  void _mostrarResultado(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Análise da $_selectedChildNome",
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
                ...(data['analise'] as List).map(
                  (res) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("• ${res['alimento']}"),
                        Text(
                          "${res['porcentagem_consumida']}%",
                          style: const TextStyle(
                            color: Color(0xFFF67B55),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "FECHAR",
              style: TextStyle(color: Color(0xFFF67B55)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color statsOrange = Color(0xFFF67B55);
    const Color primaryOrange = Color(0xFFE35D33);

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Registrar refeições",
          style: AppConstants.titleStyle,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: statsOrange))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Selecione a criança desejada",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  _buildChildDropdown(),

                  const SizedBox(height: 25),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildInstructionCard(),
                          const SizedBox(height: 20),

                          _buildCaptureCard(
                            label: "Foto ANTES da refeição",
                            foto: _fotoAntes,
                            onTap: () => _abrirOpcoesMidia(true),
                            onRemove: () => setState(() => _fotoAntes = null),
                            circleColor: statsOrange,
                          ),
                          const SizedBox(height: 20),

                          _buildCaptureCard(
                            label: "Foto DEPOIS da refeição",
                            foto: _fotoDepois,
                            onTap: () => _abrirOpcoesMidia(false),
                            onRemove: () => setState(() => _fotoDepois = null),
                            circleColor: statsOrange,
                          ),

                          const SizedBox(height: 25),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed:
                                  (_fotoAntes != null &&
                                      _fotoDepois != null &&
                                      !_loadingAnalysis)
                                  ? _executarAnalise
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryOrange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: _loadingAnalysis
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      "Analisar Consumo",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
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

  Widget _buildChildDropdown() {
    if (_pacientes.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            const Text(
              "Nenhuma criança cadastrada nesta conta.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _fetchPacientes,
              child: const Text(
                "Tentar novamente",
                style: TextStyle(
                  color: Color(0xFFF67B55),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFF67B55).withOpacity(0.5)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedChildId,
          isExpanded: true,
          dropdownColor: Colors.white,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          items: _pacientes.map((paciente) {
            return DropdownMenuItem<String>(
              value: paciente['id'],
              child: Text(
                paciente['nome'],
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              _selectedChildId = val;
              _selectedChildNome = _pacientes.firstWhere(
                (p) => p['id'] == val,
              )['nome'];
              dev.log(
                "Paciente selecionado: $_selectedChildNome",
                name: 'UPLOAD_PHOTOS',
              );
            });
          },
        ),
      ),
    );
  }

  Widget _buildInstructionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFF67B55).withOpacity(0.2)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/icons/apple.svg',
            width: 30,
            height: 30,
            colorFilter: const ColorFilter.mode(
              Color(0xFFF67B55),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Para analisar o consumo, precisaremos de uma foto do prato ANTES e outra DEPOIS da refeição.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
          ),
        ],
      ),
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
          border: Border.all(color: circleColor.withOpacity(0.2), width: 1.5),
        ),
        child: Column(
          children: [
            if (foto == null) ...[
              Icon(Icons.camera_alt, color: circleColor, size: 30),
              const SizedBox(height: 10),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            ] else ...[
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: FileImage(foto),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Foto capturada",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              // Botão para remover a foto e permitir capturar novamente
              TextButton.icon(
                onPressed: onRemove,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                  size: 18,
                ),
                label: const Text(
                  "Remover",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
