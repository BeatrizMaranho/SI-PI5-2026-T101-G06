import 'dart:developer' as dev;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_appetit/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_appetit/dataconnect_generated/generated.dart';
import 'package:provider/provider.dart';
import 'package:project_appetit/models/refeicao_model.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:project_appetit/utils/pdf_report_generator.dart';

class DocumentsScreen extends StatefulWidget {
  final String userId;

  const DocumentsScreen({super.key, required this.userId});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  List<Map<String, dynamic>> pacientes = [];
  
  String? idCriancaSelecionada; 
  String nomeCriancaSelecionada = "";
  String alergiasCriancaSelecionada = "Não";
  String pesoCriancaSelecionada = "-- kg";
  String idadeCriancaSelecionada = "--";

  bool carregando = true;
  int diasSelecionados = 7; 

  @override
  void initState() {
    super.initState();
    _fetchPacientesDashboard();
  }

  String _calcularIdade(dynamic nascimento) {
    if (nascimento == null) return "Não informada";
    try {
      DateTime dataNasc;
      if (nascimento is DateTime) {
        dataNasc = nascimento;
      } else {
        dataNasc = DateTime.parse(nascimento.toString());
      }
      
      DateTime hoje = DateTime.now();
      int anos = hoje.year - dataNasc.year;
      int meses = hoje.month - dataNasc.month;
      
      if (meses < 0) {
        anos--;
        meses += 12;
      }
      
      if (anos == 0) {
        return "$meses ${meses == 1 ? 'mês' : 'meses'}";
      } else if (meses == 0) {
        return "$anos ${anos == 1 ? 'ano' : 'anos'}";
      } else {
        return "$anos ${anos == 1 ? 'ano' : 'anos'} e $meses ${meses == 1 ? 'mês' : 'meses'}";
      }
    } catch (e) {
      return "Não informada";
    }
  }

  Future<void> _fetchPacientesDashboard() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        dev.log("Usuário não autenticado no Firebase", name: 'DASHBOARD');
        setState(() => carregando = false);
        return;
      }

      final String meuResponsavelId = user.uid;
      dev.log("Dashboard carregando dados para o UID: $meuResponsavelId", name: 'DASHBOARD');

      final resultado = await ExampleConnector.instance
          .listarMeusPacientes(responsavelId: meuResponsavelId)
          .execute();

      final List<Map<String, dynamic>> dadosDoBanco = resultado.data.pacientes
          .map((p) => {
                'id': p.id.toString(), 
                'nome': p.nome, 
                'nascimento': p.nascimento,
                'peso': p.peso, 
                'alergias': (p.alergias == null || p.alergias!.isEmpty) ? "Não" : p.alergias, 
              })
          .toList();

      dev.log("Pacientes recuperados no Dashboard: ${dadosDoBanco.length}", name: 'DASHBOARD');

      if (mounted) {
        setState(() {
          pacientes = dadosDoBanco;
          if (pacientes.isNotEmpty) {
            final primeiro = pacientes.first;
            idCriancaSelecionada = primeiro['id'];
            nomeCriancaSelecionada = primeiro['nome'];
            alergiasCriancaSelecionada = primeiro['alergias'];
            pesoCriancaSelecionada = primeiro['peso'] != null ? "${primeiro['peso']} kg" : "Não informado";
            idadeCriancaSelecionada = _calcularIdade(primeiro['nascimento']);
          }
          carregando = false;
        });
      }
    } catch (e) {
      dev.log("Erro crítico ao buscar pacientes no dashboard: $e", name: 'DASHBOARD', error: e);
      if (mounted) setState(() => carregando = false);
    }
  }

  Future<void> _gerarPdfRelatorio({
    required String nomeCrianca,
    required String idade,
    required String peso,
    required String alergias,
    required String periodo,
    required List<RefeicaoModel> todasRefeicoes,
  }) async {
    final evolucaoAlimentos = PdfReportGenerator.calcularEvolucaoAlimentos(todasRefeicoes);
    final diasAgrupados = PdfReportGenerator.agruparPorDia(todasRefeicoes);
    final estatisticas = PdfReportGenerator.calcularEstatisticas(todasRefeicoes);

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            PdfReportGenerator.gerarPaginaResume(
              nomeCrianca,
              idade,
              peso,
              alergias,
              periodo,
              estatisticas,
            ),
          ];
        },
      ),
    );

    if (diasAgrupados.isNotEmpty) {
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return [
              pw.SizedBox(height: 20),
              PdfReportGenerator.gerarTabelaHistorico(diasAgrupados),
            ];
          },
        ),
      );

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return [
              pw.SizedBox(height: 20),
              PdfReportGenerator.gerarAnaliseEvolucao(evolucaoAlimentos),
            ];
          },
        ),
      );
    }

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'relatorio_${nomeCrianca.toLowerCase().replaceAll(' ', '_')}.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color highlightOrange = Color(0xFFF67B55);
    
    if (carregando) {
      return const Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        body: Center(child: CircularProgressIndicator(color: highlightOrange)),
      );
    }

    if (pacientes.isEmpty) {
      return Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("Relatório", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.people_outline, size: 60, color: highlightOrange),
                const SizedBox(height: 16),
                const Text(
                  "Nenhuma criança vinculada a esta conta.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    setState(() => carregando = true);
                    _fetchPacientesDashboard();
                  },
                  child: const Text("Atualizar página", style: TextStyle(color: highlightOrange, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ),
      );
    }

    final provider = context.watch<RefeicaoProvider>();
    final refeicoesDoPeriodo = provider.filtrarPorPeriodo(diasSelecionados);
    String nomeBusca = nomeCriancaSelecionada.trim().toLowerCase();
    
    final listaFiltrada = refeicoesDoPeriodo.where((r) {
      return r.pacienteNome.trim().toLowerCase() == nomeBusca;
    }).toList();

    int totalBemAceitos = 0;
    int totalParciais = 0;
    int totalRejeitados = 0;

    for (var r in listaFiltrada) {
      totalBemAceitos += r.bemAceitos;
      totalParciais += r.parciais;
      totalRejeitados += r.rejeitados;
    }

    final todosAlimentos = listaFiltrada.expand((r) => r.alimentos).toList();
    
    final baixos = todosAlimentos.where((a) {
      int p = int.tryParse(a.porcentagem.replaceAll('%', '').trim()) ?? 0;
      return p < 40;
    }).toList();
    
    final parciais = todosAlimentos.where((a) {
      int p = int.tryParse(a.porcentagem.replaceAll('%', '').trim()) ?? 0;
      return p >= 40 && p < 80;
    }).toList();
    
    final aceitos = todosAlimentos.where((a) {
      int p = int.tryParse(a.porcentagem.replaceAll('%', '').trim()) ?? 0;
      return p >= 80;
    }).toList();

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Relatório", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [
            _buildCriancaDropdown(),
            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(child: _buildInfoRow("Idade:", idadeCriancaSelecionada)),
                const SizedBox(width: 12),
                Expanded(child: _buildInfoRow("Peso:", pesoCriancaSelecionada)),
              ],
            ),
            const SizedBox(height: 14),

            _buildInfoRow("Intolerância/Alergia:", alergiasCriancaSelecionada),
            const SizedBox(height: 14),

            _buildPeriodoDropdown(),
            const SizedBox(height: 20),

            _buildPdfButton(
              nome: nomeCriancaSelecionada,
              idade: idadeCriancaSelecionada,
              peso: pesoCriancaSelecionada,
              alergia: alergiasCriancaSelecionada,
              refeicoes: listaFiltrada,
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryCard(totalBemAceitos.toString(), "Bem aceitos", const Color(0xFF81C784), const Color(0xFFE8F5E9)),
                _buildSummaryCard(totalParciais.toString(), "Parciais", const Color(0xFFFFD54F), const Color(0xFFFFF9C4)),
                _buildSummaryBox(totalRejeitados.toString(), "Rejeitados", const Color(0xFFE57373), const Color(0xFFFFEBEE)),
              ],
            ),
            const SizedBox(height: 24),

            _buildCategoryList(
              title: "Alimentos com baixa aceitação", 
              itens: baixos, 
              borderColor: const Color(0xFFE57373), 
              fillColor: const Color(0xFFFFEBEE), 
              titleColor: Colors.black,
            ),
            const SizedBox(height: 16),
            
            _buildCategoryList(
              title: "Alimentos parcialmente aceitos", 
              itens: parciais, 
              borderColor: const Color(0xFFFFD54F), 
              fillColor: const Color(0xFFFFF9C4), 
              titleColor: Colors.black,
            ),
            const SizedBox(height: 16),

            _buildCategoryList(
              title: "Alimentos bem aceitos", 
              itens: aceitos, 
              borderColor: const Color(0xFF81C784), 
              fillColor: const Color(0xFFE8F5E9), 
              titleColor: Colors.black,
            ),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }


  Widget _buildCriancaDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.transparent, // Ajustado para transparente para herdar o fundo laranja/creme
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFF67B55).withOpacity(0.6), width: 1.2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: idCriancaSelecionada,
          dropdownColor: AppConstants.backgroundColor, // Garante que o menu suspenso também use a cor oficial do fundo
          isExpanded: true,
          hint: const Text("Sofia"),
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFFF67B55), size: 28),
          items: pacientes.map((paciente) {
            return DropdownMenuItem<String>(
              value: paciente['id'].toString(),
              child: Text(paciente['nome'], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black87)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              final pacienteMap = pacientes.firstWhere((p) => p['id'] == newValue);
              setState(() {
                idCriancaSelecionada = newValue;
                nomeCriancaSelecionada = pacienteMap['nome'];
                alergiasCriancaSelecionada = pacienteMap['alergias'];
                pesoCriancaSelecionada = pacienteMap['peso'] != null ? "${pacienteMap['peso']} kg" : "Não informado";
                idadeCriancaSelecionada = _calcularIdade(pacienteMap['nascimento']);
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildPeriodoDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.transparent, // Ajustado para transparente
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFF67B55).withOpacity(0.6), width: 1.2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: diasSelecionados,
          dropdownColor: AppConstants.backgroundColor, // Fundo do menu suspenso em harmonia com a tela
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFFF67B55), size: 28),
          items: const [
            DropdownMenuItem(value: 1, child: Text("Hoje", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16))),
            DropdownMenuItem(value: 7, child: Text("1 semana", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16))),
            DropdownMenuItem(value: 15, child: Text("15 dias", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16))),
            DropdownMenuItem(value: 30, child: Text("1 mês", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16))),
            DropdownMenuItem(value: 60, child: Text("2 meses", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16))),
            DropdownMenuItem(value: 90, child: Text("3 meses", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16))),
            DropdownMenuItem(value: 180, child: Text("6 meses", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16))),
            DropdownMenuItem(value: 365, child: Text("1 ano", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16))),
          ],
          onChanged: (val) => setState(() => diasSelecionados = val ?? 7),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.transparent, // Ajustado para transparente
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFF67B55).withOpacity(0.6), width: 1.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildPdfButton({
    required String nome,
    required String idade,
    required String peso,
    required String alergia,
    required List<RefeicaoModel> refeicoes,
  }) {
    String labelPeriodo = "1 semana";
    if (diasSelecionados == 1) labelPeriodo = "Hoje";
    if (diasSelecionados == 15) labelPeriodo = "15 dias";
    if (diasSelecionados == 30) labelPeriodo = "1 mês";
    if (diasSelecionados == 60) labelPeriodo = "2 meses";
    if (diasSelecionados == 90) labelPeriodo = "3 meses";
    if (diasSelecionados == 180) labelPeriodo = "6 meses";
    if (diasSelecionados == 365) labelPeriodo = "1 ano";

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () async {
          await _gerarPdfRelatorio(
            nomeCrianca: nome,
            idade: idade,
            peso: peso,
            alergias: alergia,
            periodo: labelPeriodo,
            todasRefeicoes: refeicoes,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryOrange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/pdf.svg',
              width: 20,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              placeholderBuilder: (BuildContext context) => const Icon(Icons.picture_as_pdf, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            const Text(
              "Exportar PDF",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String valor, String label, Color borderColor, Color fillColor) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.26, 
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor, width: 1.2), 
      ),
      child: Column(
        children: [
          Text(valor, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildSummaryBox(String valor, String label, Color borderColor, Color fillColor) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.26,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: Column(
        children: [
          Text(valor, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildCategoryList({
    required String title, 
    required List<AlimentoModel> itens, 
    required Color borderColor,
    required Color fillColor, 
    required Color titleColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: fillColor, 
        borderRadius: BorderRadius.circular(15), 
        border: Border.all(color: borderColor.withOpacity(0.7), width: 1.5), 
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: titleColor)),
          const SizedBox(height: 14),
          if (itens.isEmpty)
            const Text(
              "Nenhum registro no período.", 
              style: TextStyle(fontSize: 14, color: Colors.black54, fontStyle: FontStyle.italic),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: itens.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final a = itens[index];
                final exibePorcentagem = a.porcentagem.contains('%') ? a.porcentagem : "${a.porcentagem}%";
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: [
                    Text(
                      a.nome[0].toUpperCase() + a.nome.substring(1).toLowerCase(), 
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
                    ),
                    Text(exibePorcentagem, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}