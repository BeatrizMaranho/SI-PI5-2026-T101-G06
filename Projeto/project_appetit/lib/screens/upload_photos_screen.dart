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
    const Color backgroundColor = Color(0xFFF9F4F0); 
    const Color primaryOrange = Color(0xFFE35D33);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setPopupState) {
            List analise = data['analise'] ?? [];

            int bemAceitos = 0;
            int parciais = 0;
            int rejeitados = 0;

            for (var item in analise) {
              double porc = (item['porcentagem_consumida'] as num).toDouble();
              if (porc >= 80) bemAceitos++;
              else if (porc >= 40) parciais++;
              else rejeitados++;
            }

            return Dialog(
              backgroundColor: backgroundColor,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Análise concluída",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Alimentos identificados",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),

                    ...analise.map((res) {
                      double porc = (res['porcentagem_consumida'] as num).toDouble();
                      Color cardFillColor;
                      Color cardBorderColor;

                      if (porc >= 80) {
                        cardFillColor = const Color(0xFFE8F5E9);
                        cardBorderColor = const Color(0xFF81C784);
                      } else if (porc >= 40) {
                        cardFillColor = const Color(0xFFFFF9C4);
                        cardBorderColor = const Color(0xFFFFD54F);
                      } else {
                        cardFillColor = const Color(0xFFFFEBEE);
                        cardBorderColor = const Color(0xFFE57373);
                      }

                      return GestureDetector(
                        onTap: () async {
                          String? novoNome = await _dialogEditarNome(res['alimento']);
                          if (novoNome != null && novoNome.isNotEmpty) {
                            setPopupState(() {
                              res['alimento'] = novoNome;
                            });
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: cardFillColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: cardBorderColor, width: 1.2),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.edit_outlined, size: 18, color: Colors.black87),
                              const SizedBox(width: 12),
                              Text(
                                res['alimento'].toString().toUpperCase(),
                                style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
                              ),
                              const Spacer(),
                              Text(
                                "${porc.toInt()}%",
                                style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),

                    const SizedBox(height: 20),
                    const Text("Resumo", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSummaryBox(bemAceitos.toString(), "Bem aceitos", const Color(0xFF81C784), const Color(0xFFE8F5E9)),
                        _buildSummaryBox(parciais.toString(), "Parciais", const Color(0xFFFFD54F), const Color(0xFFFFF9C4)),
                        _buildSummaryBox(rejeitados.toString(), "Rejeitados", const Color(0xFFE57373), const Color(0xFFFFEBEE)),
                      ],
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryOrange,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Concluído",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSummaryBox(String valor, String label, Color borderColor, Color fillColor) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.22,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            valor,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, color: Colors.grey[800], fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // DIÁLOGO DE EDIÇÃO COM AS CORES DO APP
  Future<String?> _dialogEditarNome(String nomeAtual) {
    const Color backgroundColor = Color(0xFFF9F4F0); 
    const Color primaryOrange = Color(0xFFE35D33);
    TextEditingController controller = TextEditingController(text: nomeAtual);
    
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: backgroundColor, // Fundo creme
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "Corrigir alimento",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          cursorColor: primaryOrange,
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryOrange, width: 2),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCELAR", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryOrange,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text("SALVAR", style: TextStyle(color: Colors.white)),
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
