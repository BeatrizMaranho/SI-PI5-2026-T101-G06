import 'package:flutter/material.dart';
import 'package:project_appetit/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'child_registration_screen.dart';
import 'package:project_appetit/dataconnect_generated/generated.dart';
import 'package:intl/intl.dart';
import 'package:project_appetit/screens/edit_child_info.dart';

class ManageChildrenScreen extends StatefulWidget {
  final String userId;

  const ManageChildrenScreen({super.key, required this.userId});

  @override
  State<ManageChildrenScreen> createState() => _ManageChildrenScreenState();
}

class _ManageChildrenScreenState extends State<ManageChildrenScreen> {
  late Future<dynamic> _pacientesFuture;
  Map<String, int> _contagemRefeicoes = {};

  @override
  void initState() {
    super.initState();
    _carregarPacientes();
  }

  void _carregarPacientes() {
    setState(() {
      _pacientesFuture = ExampleConnector.instance
          .listarMeusPacientes(responsavelId: widget.userId)
          .execute()
          .then((resultado) async {
            final pacientes = resultado.data.pacientes;

            final contagens = await Future.wait(
              pacientes.map((p) async {
                try {
                  print("Buscando contagem para ID: ${p.id}");
                  final res = await ExampleConnector.instance
                      .contarRefeicoesPaciente(pacienteId: p.id)
                      .execute();
                  print(
                    "Contagem para ${p.nome}: ${res.data.refeicaos.length}",
                  );
                  return MapEntry(p.id, res.data.refeicaos.length);
                } catch (e) {
                  print("Erro ao contar refeicoes de ${p.id}: $e");
                  return MapEntry(p.id, 0);
                }
              }),
            );

            if (mounted) {
              setState(() {
                _contagemRefeicoes = Map.fromEntries(contagens);
              });
            }

            return resultado;
          });
    });
  }

  Future<void> _confirmarExclusao(
    String pacienteId,
    String nomePaciente,
  ) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Excluir criança"),
          content: Text("Tem certeza que deseja excluir $nomePaciente?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                "Excluir",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );

    if (confirmar != true) return;

    try {
      await ExampleConnector.instance.deletarPaciente(id: pacienteId).execute();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Criança excluída com sucesso"),
          backgroundColor: Colors.green,
        ),
      );

      _carregarPacientes();
    } catch (e) {
      print("Erro ao excluir paciente: $e");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao excluir: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  int calcularIdade(dynamic nascimento) {
    if (nascimento == null) return 0;

    DateTime dataNasc = nascimento is String
        ? DateTime.parse(nascimento)
        : nascimento;

    DateTime hoje = DateTime.now();
    int idade = hoje.year - dataNasc.year;

    if (hoje.month < dataNasc.month ||
        (hoje.month == dataNasc.month && hoje.day < dataNasc.day)) {
      idade--;
    }

    return idade;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Gerenciar crianças', style: AppConstants.titleStyle),
      ),
      body: FutureBuilder(
        future: _pacientesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppConstants.primaryOrange,
              ),
            );
          }

          if (snapshot.hasError) {
            print("ERRO NO FUTUREBUILDER: ${snapshot.error}");
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Erro ao carregar dados"),
                  const SizedBox(height: 10),
                  Text(
                    "${snapshot.error}",
                    style: const TextStyle(fontSize: 10, color: Colors.red),
                  ),
                ],
              ),
            );
          }

          final pacientes = snapshot.data?.data.pacientes ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Crianças cadastradas',
                  style: AppConstants.sectionStyle,
                ),
                const SizedBox(height: AppConstants.defaultPadding),

                if (pacientes.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Nenhuma criança cadastrada",
                        style: TextStyle(color: AppConstants.textGrey),
                      ),
                    ),
                  ),

                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pacientes.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: AppConstants.elementSpacing),
                  itemBuilder: (context, index) {
                    final paciente = pacientes[index];

                    final int idadeCalculada = calcularIdade(
                      paciente.nascimento,
                    );

                    final int totalRefeicoes =
                        _contagemRefeicoes[paciente.id] ?? 0;

                    return childCard(
                      context,
                      paciente.nome,
                      "$idadeCalculada anos",
                      totalRefeicoes.toString(),
                      DateFormat(
                        'dd/MM/yyyy',
                      ).format(paciente.criadoEm.toDateTime()),
                      AppConstants.borderOrange,
                      AppConstants.primaryOrange,
                      onCameraTap: () {
                        Navigator.pushNamed(
                          context,
                          '/upload-photos',
                          arguments: {
                            'selectedChildId': paciente.id,
                            'selectedChildName': paciente.nome,
                          },
                        );
                      },
                      onEditInfosTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditChildInfoScreen(
                              childId: paciente.id,
                              nomeInicial: paciente.nome,
                              nascimentoInicial:
                                  paciente.nascimento ?? DateTime.now(),
                              pesoInicial: paciente.peso ?? 0.0,
                              alergiasInicial: paciente.alergias ?? '',
                            ),
                          ),
                        );

                        _carregarPacientes();
                      },
                      onDeleteTap: () {
                        print("ID do paciente: ${paciente.id}");
                        _confirmarExclusao(paciente.id, paciente.nome);
                      },
                    );
                  },
                ),

                const SizedBox(height: AppConstants.elementSpacing),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChildRegistrationScreen(),
                        ),
                      );

                      _carregarPacientes();
                    },
                    icon: const Icon(Icons.add, color: AppConstants.iconLight),
                    label: const Text(
                      'Adicionar nova criança',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppConstants.iconLight,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryOrange,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.buttonBorderRadius,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.elementSpacing),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget childCard(
    BuildContext context,
    String nome,
    String idade,
    String refeicoes,
    String data,
    Color statsColor,
    Color actionColor, {
    required VoidCallback onCameraTap,
    required VoidCallback onEditInfosTap,
    required VoidCallback onDeleteTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.cardPadding),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: statsColor.withOpacity(0.3), width: 1.2),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(
                  'assets/icons/user-img.svg',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nome, style: AppConstants.cardTitleStyle),
                  Text(
                    idade,
                    style: const TextStyle(color: AppConstants.textGrey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              expandedInfoBox(
                "Refeições",
                refeicoes,
                Icons.restaurant,
                statsColor,
              ),
              const SizedBox(width: 10),
              expandedInfoBox("Desde", data, Icons.calendar_today, statsColor),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              actionButton(Icons.camera_alt, actionColor, onTap: onCameraTap),
              actionButton(Icons.edit, actionColor, onTap: onEditInfosTap),
              actionButton(Icons.delete, actionColor, onTap: onDeleteTap),
            ],
          ),
        ],
      ),
    );
  }

  Widget expandedInfoBox(
    String label,
    String value,
    IconData icon,
    Color statsColor,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: statsColor,
          borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 14, color: AppConstants.iconLight),
                const SizedBox(width: 5),
                Text(
                  label,
                  style: const TextStyle(
                    color: AppConstants.iconLight,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: AppConstants.iconLight,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget actionButton(IconData icon, Color actionColor, {VoidCallback? onTap}) {
    return SizedBox(
      width: 80,
      height: 45,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: actionColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Icon(icon, color: AppConstants.iconLight, size: 20),
      ),
    );
  }
}
