import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_appetit/constants.dart';
import 'package:project_appetit/screens/tirar_fotos_screen.dart'; 
import 'package:project_appetit/screens/galeria_fotos_screen.dart'; 
import 'package:project_appetit/service/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 🔥 IMPORTANTE

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

  @override
  void initState() {
    super.initState();
    _fetchPacientes(); 
  }

  Future<void> _fetchPacientes() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print("❌ Usuário não logado");
        setState(() => _isLoading = false);
        return;
      }

      final String meuResponsavelId = user.uid;

      print("🆔 UID LOGADO: $meuResponsavelId");

      final List<Map<String, dynamic>> dadosDoBanco =
          await ApiService.buscarPacientes(meuResponsavelId);

      if (mounted) {
        setState(() {
          _pacientes = dadosDoBanco;

          if (_pacientes.isNotEmpty) {
            _selectedChildId = _pacientes[0]['id'];
            _selectedChildNome = _pacientes[0]['nome'];
          }

          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
      debugPrint("Erro ao carregar pacientes: $e");
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
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFF67B55)))
          : Padding(
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
                      onTap: () {
                        if (_selectedChildId != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TirarFotosScreen(
                                nomeCrianca: _selectedChildNome,
                                pacienteId: _selectedChildId!,
                              ),
                            ),
                          );
                        }
                      },
                      isEnabled: _selectedChildId != null,
                    ),
                    const SizedBox(height: 20),
                    
                    _buildOptionCard(
                      svgPath: 'assets/icons/upload.svg',
                      label: "Escolher da galeria",
                      onTap: () {
                        if (_selectedChildId != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GaleriaFotosScreen(
                                nomeCrianca: _selectedChildNome,
                                pacienteId: _selectedChildId!,
                              ),
                            ),
                          );
                        }
                      },
                      isEnabled: _selectedChildId != null,
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
              "⚠️ Nenhuma criança cadastrada nesta conta.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _fetchPacientes, 
              child: const Text("Tentar novamente", style: TextStyle(color: Color(0xFFF67B55), fontWeight: FontWeight.bold))
            )
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
              child: Text(paciente['nome'], style: const TextStyle(fontSize: 16, color: Colors.black))
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              _selectedChildId = val;
              _selectedChildNome = _pacientes.firstWhere((p) => p['id'] == val)['nome'];
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
            colorFilter: const ColorFilter.mode(Color(0xFFF67B55), BlendMode.srcIn),
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
              )
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
                      BlendMode.srcIn
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