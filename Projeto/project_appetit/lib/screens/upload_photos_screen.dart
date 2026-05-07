import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_appetit/constants.dart';
import 'package:project_appetit/screens/galeria_fotos_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as dev;
import 'package:project_appetit/dataconnect_generated/generated.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> _abrirCamera() async {
    if (_selectedChildId == null) {
      _mostrarAvisoSemCrianca();
      return;
    }

    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        dev.log("Foto tirada: ${photo.path}", name: 'UPLOAD_PHOTOS');
      }
    } catch (e) {
      dev.log("Erro ao abrir câmera: $e", name: 'UPLOAD_PHOTOS', error: e);
    }
  }

  Future<void> _abrirGaleria() async {
    if (_selectedChildId == null) {
      _mostrarAvisoSemCrianca();
      return;
    }

    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        dev.log(
          "Imagem da galeria escolhida: ${image.path}",
          name: 'UPLOAD_PHOTOS',
        );
      }
    } catch (e) {
      dev.log("Erro ao abrir galeria: $e", name: 'UPLOAD_PHOTOS', error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFF67B55)),
            )
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

                  const SizedBox(height: 30),
                  const Text(
                    "Como deseja adicionar a foto?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildInstructionCard(),
                          const SizedBox(height: 20),

                          _buildOptionCard(
                            svgPath: 'assets/icons/camera.svg',
                            label: "Tirar foto agora",
                            onTap: _abrirCamera,
                            isEnabled: true,
                          ),
                          const SizedBox(height: 20),

                          _buildOptionCard(
                            svgPath: 'assets/icons/upload.svg',
                            label: "Escolher da galeria",
                            onTap: _abrirGaleria,
                            isEnabled: true,
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

  Widget _buildOptionCard({
    required String svgPath,
    required String label,
    required VoidCallback onTap,
    bool isEnabled = true,
  }) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color(0xFFF67B55).withOpacity(0.1),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                  color: Color(0xFFF67B55),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    svgPath,
                    width: 35,
                    height: 35,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
