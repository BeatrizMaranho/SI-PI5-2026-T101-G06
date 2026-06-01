import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_appetit/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as dev;
import 'package:project_appetit/dataconnect_generated/generated.dart';
import 'package:image_picker/image_picker.dart' as picker;
import 'dart:io';
import 'package:project_appetit/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:project_appetit/models/refeicao_model.dart';

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
  Map<String, dynamic>? pacienteSelecionado;

  File? _fotoAntes;
  File? _fotoDepois;

  bool _dicaMostrada = false;

  final picker.ImagePicker _picker = picker.ImagePicker();

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
        
        // Sincroniza os argumentos recebidos por rota na memória global
        RefeicaoModel.idCriancaAtiva = childId;
        RefeicaoModel.nomeCriancaAtiva = childName;
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
          .map((p) => {'id': p.id.toString(), 'nome': p.nome, 'nascimento': p.nascimento})
          .toList();

      dev.log(
        "Pacientes encontrados: ${dadosDoBanco.length}",
        name: 'UPLOAD_PHOTOS',
      );

      if (mounted) {
        setState(() {
          _pacientes = dadosDoBanco;

          if (_pacientes.isNotEmpty) {
            // Verifica se alguma aba anterior (como Relatórios) já marcou uma criança ativa globalmente
            if (RefeicaoModel.idCriancaAtiva != null && _selectedChildId == null) {
              _selectedChildId = RefeicaoModel.idCriancaAtiva;
              pacienteSelecionado = _pacientes.firstWhere(
                (p) => p['id'].toString() == _selectedChildId,
                orElse: () => _pacientes[0],
              );
              _selectedChildId = pacienteSelecionado?['id'].toString();
              _selectedChildNome = pacienteSelecionado?['nome'] ?? '';
              RefeicaoModel.nomeCriancaAtiva = _selectedChildNome;
            } else if (_selectedChildId == null) {
              // Se não houver nada salvo, usa o primeiro da lista e inicia as variáveis estáticas
              _selectedChildId = _pacientes[0]['id'].toString();
              _selectedChildNome = _pacientes[0]['nome'];
              pacienteSelecionado = _pacientes[0];
              
              RefeicaoModel.idCriancaAtiva = _selectedChildId;
              RefeicaoModel.nomeCriancaAtiva = _selectedChildNome;
            } else {
              pacienteSelecionado = _pacientes.firstWhere(
                (p) => p['id'].toString() == _selectedChildId,
                orElse: () => _pacientes[0],
              );
            }

            dev.log(
              "Paciente ativo para análise: $_selectedChildNome",
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

  void _mostrarAvisoOrdem() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Por favor, adicione a imagem "antes" da refeição primeiro.',
        ),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _iniciarCaptura(bool isAntes) {
    if (_selectedChildId == null) {
      _mostrarAvisoSemCrianca();
      return;
    }

    if (!isAntes && _fotoAntes == null) {
      _mostrarAvisoOrdem();
      return;
    }

    if (!_dicaMostrada) {
      _mostrarDicaImportante(isAntes);
    } else {
      _abrirOpcoesMidia(isAntes);
    }
  }

  void _mostrarDicaImportante(bool isAntes) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFFFBF9F6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Dica importante",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Tire as fotos do prato sempre no mesmo ângulo e de cima, tentando manter a mesma distância antes e depois da refeição.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: SvgPicture.asset(
                    'assets/icons/top-picture.svg',
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  "Isso ajuda o aplicativo a comparar corretamente os alimentos consumidos.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _dicaMostrada = true;
                      });
                      Navigator.of(context).pop();
                      _abrirOpcoesMidia(isAntes);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE25B36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Concluído",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _abrirOpcoesMidia(bool isAntes) {
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
                leading: const Icon(
                  Icons.camera_alt,
                  color: AppConstants.primaryOrange,
                ),
                title: const Text('Tirar foto agora'),
                onTap: () {
                  Navigator.of(context).pop();
                  _capturarMedia(isAntes, picker.ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: AppConstants.primaryOrange,
                ),
                title: const Text('Escolher da galeria'),
                onTap: () {
                  Navigator.of(context).pop();
                  _capturarMedia(isAntes, picker.ImageSource.gallery);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _recapturarFoto(bool isAntes) {
    if (_selectedChildId == null) {
      _mostrarAvisoSemCrianca();
      return;
    }

    // Ambas as fotos (antes e depois) vão direto para a galeria ao clicar em "Anexar"
    _capturarMedia(isAntes, picker.ImageSource.gallery);
  }

  Future<void> _capturarMedia(bool isAntes, picker.ImageSource source) async {
    try {
      final picker.XFile? picked = await _picker.pickImage(
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
        picker.XFile(_fotoAntes!.path),
        picker.XFile(_fotoDepois!.path),
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
    const Color primaryOrange = AppConstants.primaryOrange;

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
              if (porc >= 80)
                bemAceitos++;
              else if (porc >= 40)
                parciais++;
              else
                rejeitados++;
            }

            return Dialog(
              backgroundColor: backgroundColor,
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
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
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _fotoAntes = null;
                              _fotoDepois = null;
                            });
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Alimentos identificados",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...analise.map((res) {
                      double porc = (res['porcentagem_consumida'] as num)
                          .toDouble();
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
                          String? novoNome = await _dialogEditarNome(
                            res['alimento'],
                          );
                          if (novoNome != null && novoNome.isNotEmpty) {
                            setPopupState(() {
                              res['alimento'] = novoNome;
                            });
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: cardFillColor,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: cardBorderColor,
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.edit_outlined,
                                size: 18,
                                color: Colors.black87,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                res['alimento'].toString().toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "${porc.toInt()}%",
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 20),
                    const Text(
                      "Resumo",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSummaryBox(
                          bemAceitos.toString(),
                          "Bem aceitos",
                          const Color(0xFF81C784),
                          const Color(0xFFE8F5E9),
                        ),
                        _buildSummaryBox(
                          parciais.toString(),
                          "Parciais",
                          const Color(0xFFFFD54F),
                          const Color(0xFFFFF9C4),
                        ),
                        _buildSummaryBox(
                          rejeitados.toString(),
                          "Rejeitados",
                          const Color(0xFFE57373),
                          const Color(0xFFFFEBEE),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          List<AlimentoModel> listaParaSalvar = analise.map((
                            item,
                          ) {
                            return AlimentoModel(
                              nome: item['alimento'].toString(),
                              porcentagem:
                                  (item['porcentagem_consumida'] as num)
                                      .toInt()
                                      .toString(),
                            );
                          }).toList();

                          final novaRefeicao = RefeicaoModel(
                            pacienteNome:
                                pacienteSelecionado?['nome'] ?? "Sofia",
                            data: DateTime.now(),
                            alimentos: listaParaSalvar,
                            fotoAntes: data['foto_antes_path'] ?? "",
                            fotoDepois: data['foto_depois_path'] ?? "",
                          );

                          Provider.of<RefeicaoProvider>(
                            context,
                            listen: false,
                          ).salvarRefeicao(novaRefeicao);

                          setState(() {
                            _fotoAntes = null;
                            _fotoDepois = null;
                          });

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Análise salva com sucesso!"),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Concluído",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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

  Widget _buildSummaryBox(
    String valor,
    String label,
    Color borderColor,
    Color fillColor,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.22,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            valor,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _dialogEditarNome(String nomeAtual) {
    const Color backgroundColor = Color(0xFFF9F4F0);
    const Color primaryOrange = AppConstants.primaryOrange;
    TextEditingController controller = TextEditingController(text: nomeAtual);

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("SALVAR", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppConstants.textBlack,
            size: 22,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          "Registrar refeições",
          style: TextStyle(
            color: AppConstants.textBlack,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppConstants.primaryOrange,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Selecione a criança desejada",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.textBlack,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildChildDropdown(),

                  const SizedBox(height: 25),

                  Text(
                    (_fotoAntes == null && _fotoDepois == null)
                        ? "Como deseja adicionar a foto?"
                        : "Fotos da refeição",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.textBlack,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (_fotoAntes == null && _fotoDepois == null) ...[
                            _buildInstructionCard(),
                            const SizedBox(height: 20),

                            _buildActionButton(
                              label: "Tirar foto agora",
                              iconPath: "assets/icons/camera.svg",
                              onTap: () => _capturarMedia(true, picker.ImageSource.camera),
                            ),
                            const SizedBox(height: 20),

                            _buildActionButton(
                              label: "Escolher da galeria",
                              iconPath: "assets/icons/upload.svg",
                              onTap: () => _capturarMedia(true, picker.ImageSource.gallery),
                            ),
                          ] else ...[
                            _buildCaptureCard(
                              label: "Tirar foto antes da refeição",
                              foto: _fotoAntes,
                              onTap: () => _recapturarFoto(true),
                              onRemove: () => setState(() => _fotoAntes = null),
                            ),
                            const SizedBox(height: 20),

                            _buildCaptureCard(
                              label: "Tirar foto depois da refeição",
                              foto: _fotoDepois,
                              onTap: () => _recapturarFoto(false),
                              onRemove: () => setState(() => _fotoDepois = null),
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
                                  backgroundColor: AppConstants.primaryOrange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 0,
                                ),
                                child: _loadingAnalysis
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        "Analisar",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            _buildPersistenceWarningCard(),
                          ],
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
                  color: AppConstants.primaryOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppConstants.primaryOrange.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedChildId,
          isExpanded: true,
          hint: const Text("Selecione a criança"),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppConstants.textBlack,
            size: 28,
          ),
          items: _pacientes.map((paciente) {
            return DropdownMenuItem<String>(
              value: paciente['id'].toString(),
              child: Text(
                paciente['nome'],
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppConstants.textBlack,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedChildId = newValue;
                pacienteSelecionado = _pacientes.firstWhere(
                  (p) => p['id'].toString() == newValue,
                );
                _selectedChildNome = pacienteSelecionado!['nome'];
                
                // Sincroniza a seleção do Dropdown com a memória global
                RefeicaoModel.idCriancaAtiva = newValue;
                RefeicaoModel.nomeCriancaAtiva = _selectedChildNome;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildInstructionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor,
        border: Border.all(
          color: AppConstants.primaryOrange.withOpacity(0.3),
          width: 1.5,
         ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/apple.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppConstants.textBlack,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Tire uma foto ou envie uma imagem da refeição. Você deve adicionar uma foto antes e uma após a refeição.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: AppConstants.textBlack,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 32),
        decoration: BoxDecoration(
          color: AppConstants.backgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppConstants.primaryOrange.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppConstants.primaryOrange.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                iconPath,
                width: 32,
                height: 32,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppConstants.textBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaptureCard({
    required String label,
    required File? foto,
    required VoidCallback onTap,
    required VoidCallback onRemove,
  }) {
    return GestureDetector(
      onTap: foto == null ? onTap : null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        decoration: BoxDecoration(
          color: AppConstants.backgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppConstants.primaryOrange.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppConstants.primaryOrange.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                "assets/icons/camera.svg",
                width: 32,
                height: 32,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppConstants.textBlack,
              ),
            ),
            if (foto != null) ...[
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Nome_foto.png",
                    style: TextStyle(
                      color: AppConstants.textGrey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onRemove,
                    child: const Icon(
                      Icons.close,
                      color: AppConstants.textBlack,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPersistenceWarningCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor,
        border: Border.all(
          color: AppConstants.primaryOrange.withOpacity(0.3),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/apple.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppConstants.textBlack,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "As fotos ficam salvas mesmo se você sair. Você pode completar as informações da refeição depois!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: AppConstants.textBlack,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}