import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:project_appetit/models/refeicao_model.dart';

/// Estrutura para armazenar dados de um alimento ao longo do período
class AlimentoEvolution {
  final String nome;
  final int timesOffered;
  final double averageAcceptance;
  final List<double> dailyAcceptances;
  
  AlimentoEvolution({
    required this.nome,
    required this.timesOffered,
    required this.averageAcceptance,
    required this.dailyAcceptances,
  });
}

/// Estrutura para armazenar dados de um dia específico
class DayData {
  final DateTime date;
  final List<dynamic> alimentos; // Mantido dinâmico para compatibilidade com AlimentoModel
  final double averageAcceptance;
  
  DayData({
    required this.date,
    required this.alimentos,
    required this.averageAcceptance,
  });
}

/// Serviço profissional para geração de relatórios em PDF para acompanhamento clínico
/// de seletividade alimentar infantil.
class PdfReportGenerator {

  /// Agrupa alimentos por nome e calcula evolução histórica
  static Map<String, AlimentoEvolution> calcularEvolucaoAlimentos(
    List<RefeicaoModel> refeicoes,
  ) {
    final alimentoMap = <String, List<double>>{};
    
    for (var refeicao in refeicoes) {
      for (var alimento in refeicao.alimentos) {
        final percentual = double.tryParse(
          alimento.porcentagem.replaceAll('%', '').trim(),
        ) ?? 0;
        
        alimentoMap.putIfAbsent(alimento.nome, () => []).add(percentual);
      }
    }
    
    final evolucao = <String, AlimentoEvolution>{};
    alimentoMap.forEach((nome, percentuais) {
      final average = percentuais.reduce((a, b) => a + b) / percentuais.length;
      evolucao[nome] = AlimentoEvolution(
        nome: nome,
        timesOffered: percentuais.length,
        averageAcceptance: average,
        dailyAcceptances: percentuais,
      );
    });
    
    return evolucao;
  }

  /// Agrupa refeições por data cronológica
  static List<DayData> agruparPorDia(List<RefeicaoModel> refeicoes) {
    final mapa = <DateTime, List<RefeicaoModel>>{};
    
    for (var refeicao in refeicoes) {
      final data = DateTime(
        refeicao.data.year,
        refeicao.data.month,
        refeicao.data.day,
      );
      mapa.putIfAbsent(data, () => []).add(refeicao);
    }
    
    final dias = <DayData>[];
    mapa.forEach((data, refeicoes) {
      final todosAlimentos = refeicoes.expand((r) => r.alimentos).toList();
      final mediaAceicao = todosAlimentos.isEmpty
          ? 0.0
          : todosAlimentos
              .map((a) => double.tryParse(a.porcentagem.replaceAll('%', '')) ?? 0)
              .reduce((a, b) => a + b) /
              todosAlimentos.length;
      
      dias.add(DayData(
        date: data,
        alimentos: todosAlimentos,
        averageAcceptance: mediaAceicao,
      ));
    });
    
    dias.sort((a, b) => b.date.compareTo(a.date));
    return dias;
  }

  /// Calcula estatísticas avançadas com foco em indicadores ouro de seletividade
  static Map<String, dynamic> calcularEstatisticas(List<RefeicaoModel> refeicoes) {
    int totalRefeicoes = refeicoes.length;
    int totalAlimentosExpostos = 0;
    double somaAceicao = 0;
    int alimentosBemAceitos = 0;
    int alimentosParciais = 0;
    int alimentosRejeitados = 0;
    final repertorioAlimentar = <String>{};
    
    for (var refeicao in refeicoes) {
      totalAlimentosExpostos += refeicao.alimentos.length;
      alimentosBemAceitos += refeicao.bemAceitos;
      alimentosParciais += refeicao.parciais;
      alimentosRejeitados += refeicao.rejeitados;
      
      for (var alimento in refeicao.alimentos) {
        repertorioAlimentar.add(alimento.nome.trim().toLowerCase());
        final percentual = double.tryParse(
          alimento.porcentagem.replaceAll('%', '').trim(),
        ) ?? 0;
        somaAceicao += percentual;
      }
    }
    
    final mediaGeral = totalAlimentosExpostos > 0 ? somaAceicao / totalAlimentosExpostos : 0;
    
    return {
      'totalRefeicoes': totalRefeicoes,
      'totalAlimentos': totalAlimentosExpostos,
      'mediaGeral': mediaGeral,
      'bemAceitos': alimentosBemAceitos,
      'parciais': alimentosParciais,
      'rejeitados': alimentosRejeitados,
      'diasComDados': agruparPorDia(refeicoes).length,
      'repertorioTotal': repertorioAlimentar.length, // Novo indicador clínico essencial
    };
  }

  /// Capa profissional do Relatório Clínico com matriz 2x2 de indicadores
  static pw.Widget gerarPaginaResume(
    String nomeCrianca,
    String idade,
    String peso,
    String alergias,
    String periodo,
    Map<String, dynamic> estatisticas,
  ) {
    final mediaGeral = estatisticas['mediaGeral'] as double;
    final totalAlimentos = estatisticas['totalAlimentos'] as int;
    final diasComDados = estatisticas['diasComDados'] as int;
    final repertorioTotal = estatisticas['repertorioTotal'] as int? ?? 0;
    final bemAceitos = estatisticas['bemAceitos'] as int;
    final parciais = estatisticas['parciais'] as int;
    final rejeitados = estatisticas['rejeitados'] as int;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Identificação Institucional / Profissional
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'PROJECT APPETIT * CLINICAL REPORT',
              style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: PdfColors.grey500),
            ),
            pw.Text(
              'Acompanhamento Terapêutico Nutricional',
              style: pw.TextStyle(fontSize: 9, color: PdfColors.grey500),
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Divider(thickness: 1, color: PdfColors.grey300),
        pw.SizedBox(height: 15),

        // Título Principal
        pw.Center(
          child: pw.Text(
            'Relatório de Evolução Alimentar',
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.orange900),
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Center(
          child: pw.Text(
            'Mapeamento Analítico de Padrões de Seletividade e Aceitação Recorrentes',
            style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600, fontStyle: pw.FontStyle.italic),
          ),
        ),
        pw.SizedBox(height: 20),

        // Prontuário / Dados do Paciente
        pw.Text('1. Perfil Clínico do Paciente', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColors.grey800)),
        pw.SizedBox(height: 6),
        pw.Container(
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey50,
            border: pw.Border.all(color: PdfColors.grey300, width: 1),
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
          ),
          child: pw.Column(
            children: [
              _buildProntuarioRow('Paciente:', nomeCrianca, 'Período:', periodo),
              pw.SizedBox(height: 6),
              _buildProntuarioRow('Idade Cronológica:', idade, 'Massa Corporal:', peso),
              pw.SizedBox(height: 6),
              _buildProntuarioRow('Restrições/Alergias:', alergias, 'Status de Registro:', 'Ativo'),
            ],
          ),
        ),
        pw.SizedBox(height: 25),

        // Grade 2x2 de Indicadores Críticos de Seletividade
        pw.Text('2. Indicadores Consolidados do Período', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColors.grey800)),
        pw.SizedBox(height: 8),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            _buildMetricaCardProfessional('Índice de Aceitação Médio', '${mediaGeral.toStringAsFixed(1)}%', 'Volume médio consumido ponderado por refeição.'),
            _buildMetricaCardProfessional('Repertório Alimentar', '$repertorioTotal itens', 'Quantidade de alimentos únicos apresentados.'),
          ],
        ),
        pw.SizedBox(height: 12),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            _buildMetricaCardProfessional('Exposições Totais', '$totalAlimentos ofertas', 'Frequência de interações com comida no prato.'),
            _buildMetricaCardProfessional('Dias Monitorados', '$diasComDados dias', 'Janela temporal com registros fotográficos válidos.'),
          ],
        ),
        pw.SizedBox(height: 25),

        // Distribuição Panorâmica (Ingestão vs Recusa)
        pw.Text('3. Distribuição de Comportamento Alimentar por Item Ofertado', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColors.grey800)),
        pw.SizedBox(height: 4),
        pw.Text('Frequência absoluta onde o alimento atingiu os limiares de ingestão estabelecidos:', style: pw.TextStyle(fontSize: 9, color: PdfColors.grey600)),
        pw.SizedBox(height: 10),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            _buildDistribuicaoCardProfessional('Bem Aceitos (>=80%)', bemAceitos.toString(), PdfColors.green700, 'Alimentos considerados "seguros" no repertório atual.'),
            _buildDistribuicaoCardProfessional('Aceitação Parcial (40-79%)', parciais.toString(), PdfColors.amber700, 'Janela de habituação e transição sensorial.'),
            _buildDistribuicaoCardProfessional('Rejeitados (<40%)', rejeitados.toString(), PdfColors.red700, 'Recusa ativa significativa ou desinteresse.'),
          ],
        ),
        pw.SizedBox(height: 30),
        
        // Guia Clínico de Apoio Pedagógico
        pw.Container(
          padding: const pw.EdgeInsets.all(10),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.orange200, width: 1),
            color: PdfColors.orange50,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Diretriz de Leitura Terapêutica para Pais e Clínicos:', style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: PdfColors.orange900)),
              pw.SizedBox(height: 4),
              pw.Text(
                '* A Seletividade Alimentar é mitigada por exposição repetida espontânea. Itens na categoria "Parcial" representam progresso motor-oral e sensorial expressivo; não force a ingestão completa. Identifique rejeições recorrentes nas tabelas subsequentes para modular texturas, cores ou formas de preparo.',
                style: pw.TextStyle(fontSize: 8.5, color: PdfColors.grey800, lineSpacing: 1.2),
              ),
            ],
          ),
        )
      ],
    );
  }

  /// Nova Tabela Estruturada Dia a Dia (Com cálculo explícito de Aceitação vs Rejeição)
  static pw.Widget gerarTabelaHistorico(List<DayData> diasAgrupados) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          '4. Histórico Clínico Cronológico (Dia a Dia)',
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.grey800),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'Mapeamento completo e pormenorizado de alimentos registrados via imagem por data:',
          style: pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
        ),
        pw.SizedBox(height: 14),
        
        for (int i = 0; i < diasAgrupados.length; i++) ...[
          pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 12),
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300, width: 1),
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
              color: i % 2 == 0 ? PdfColors.white : PdfColors.grey50,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Linha de cabeçalho do Dia
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      _formatarData(diasAgrupados[i].date).toUpperCase(),
                      style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColors.blueGrey800),
                    ),
                    pw.Text(
                      'Média Diária de Ingestão: ${diasAgrupados[i].averageAcceptance.toStringAsFixed(1)}%',
                      style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: PdfColors.orange900),
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),
                
                // Tabela de Alimentos do Dia (Alinhamento profissional e cores nas sobras)
                pw.Table(
                  border: const pw.TableBorder(
                    horizontalInside: pw.BorderSide(color: PdfColors.grey200, width: 0.5),
                    bottom: pw.BorderSide(color: PdfColors.grey300, width: 0.5),
                  ),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(3.5),  // Nome Alimento
                    1: const pw.FixedColumnWidth(70),  // % Aceitação (Verde)
                    2: const pw.FixedColumnWidth(70),  // % Rejeição / Sobra (Vermelho)
                    3: const pw.FlexColumnWidth(2),    // Impacto Sensorial
                  },
                  children: [
                    // Header da Tabela Interna
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                      children: [
                        pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Alimento Ofertado', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold))),
                        pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Aceitação', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.right)),
                        pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Rejeitado (Sobra)', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.right)),
                        pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Status Sensorial', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                      ],
                    ),
                    // Alimentos iterados
                    ...diasAgrupados[i].alimentos.map((alimento) {
                      final aceitacao = double.tryParse(alimento.porcentagem.replaceAll('%', '').trim()) ?? 0;
                      final rejeicao = 100 - aceitacao;
                      
                      return pw.TableRow(
                        children: [
                          pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 4), child: pw.Text(alimento.nome, style: const pw.TextStyle(fontSize: 9))),
                          pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 4), 
                            child: pw.Text('${aceitacao.toStringAsFixed(0)}%', style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: PdfColors.green700), textAlign: pw.TextAlign.right)
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 4), 
                            child: pw.Text(
                              '${rejeicao.toStringAsFixed(0)}%', 
                              style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: rejeicao > 0 ? PdfColors.red700 : PdfColors.grey400), 
                              textAlign: pw.TextAlign.right
                            )
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 4), 
                            child: pw.Text(_getStatusAlimento(aceitacao), style: pw.TextStyle(fontSize: 8, color: _getCorStatusAlimento(aceitacao)), textAlign: pw.TextAlign.center)
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  /// Nova Análise de Evolução (Fornece insights automáticos para o profissional)
  static pw.Widget gerarAnaliseEvolucao(
    Map<String, AlimentoEvolution> evolucao,
  ) {
    final alimentosOrdenados = evolucao.values.toList()
        ..sort((a, b) => b.averageAcceptance.compareTo(a.averageAcceptance));

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          '5. Análise de Padrão e Frequência de Alimentos Ofertados',
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.grey800),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'Diagnóstico automatizado de aceitação longitudinal baseado no histórico de exposições repetidas:',
          style: pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
        ),
        pw.SizedBox(height: 14),

        pw.Table(
          border: const pw.TableBorder(
            horizontalInside: pw.BorderSide(color: PdfColors.grey200, width: 0.5),
            bottom: pw.BorderSide(color: PdfColors.grey400, width: 1),
          ),
          columnWidths: {
            0: const pw.FlexColumnWidth(2.5), // Nome
            1: const pw.FixedColumnWidth(60),  // Frequência
            2: const pw.FixedColumnWidth(80),  // Média Aceitação
            3: const pw.FlexColumnWidth(3),   // Parecer Terapêutico Automatizado
          },
          children: [
            // Header
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.blueGrey700),
              children: [
                pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Alimento Ofertado', style: pw.TextStyle(fontSize: 8.5, fontWeight: pw.FontWeight.bold, color: PdfColors.white))),
                pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Exposições', style: pw.TextStyle(fontSize: 8.5, fontWeight: pw.FontWeight.bold, color: PdfColors.white), textAlign: pw.TextAlign.right)),
                pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Média de Ingestão', style: pw.TextStyle(fontSize: 8.5, fontWeight: pw.FontWeight.bold, color: PdfColors.white), textAlign: pw.TextAlign.right)),
                pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Diretriz Clínica Interpretativa', style: pw.TextStyle(fontSize: 8.5, fontWeight: pw.FontWeight.bold, color: PdfColors.white), textAlign: pw.TextAlign.center)),
              ],
            ),
            // Linhas de Alimentos
            for (var item in alimentosOrdenados)
              pw.TableRow(
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(item.nome, style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold))),
                  pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('${item.timesOffered}x', style: const pw.TextStyle(fontSize: 9), textAlign: pw.TextAlign.right)),
                  pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('${item.averageAcceptance.toStringAsFixed(1)}%', style: const pw.TextStyle(fontSize: 9), textAlign: pw.TextAlign.right)),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(6), 
                    child: pw.Text(
                      _calcularDiretrizClinica(item.timesOffered, item.averageAcceptance), 
                      style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey900), 
                      textAlign: pw.TextAlign.left
                    )
                  ),
                ],
              ),
          ],
        ),
        pw.SizedBox(height: 35),
        
        // Campo de assinatura e parecer do profissional de saúde
        pw.Divider(color: PdfColors.grey400, thickness: 0.5),
        pw.SizedBox(height: 20),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(width: 200, child: pw.Divider(color: PdfColors.grey600, thickness: 1)),
                pw.SizedBox(height: 2),
                pw.Text('Assinatura do Profissional de Saúde', style: pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
              ],
            ),
            pw.Text(
              'Documento emitido pelo app Project Appetit em ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
              style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
            )
          ]
        )
      ],
    );
  }

  // --- MÉTODOS AUXILIARES PROFISSIONAIS ---

  static pw.Widget _buildProntuarioRow(String label1, String value1, String label2, String value2) {
    final lblStyle = pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: PdfColors.grey700);
    final valStyle = const pw.TextStyle(fontSize: 9, color: PdfColors.black);
    
    return pw.Row(
      children: [
        pw.SizedBox(width: 100, child: pw.Text(label1, style: lblStyle)),
        pw.Expanded(child: pw.Text(value1, style: valStyle)),
        pw.SizedBox(width: 100, child: pw.Text(label2, style: lblStyle)),
        pw.SizedBox(width: 120, child: pw.Text(value2, style: valStyle)),
      ],
    );
  }

  static pw.Widget _buildMetricaCardProfessional(String label, String valor, String descricao) {
    return pw.Container(
      width: 255,
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        border: pw.Border.all(color: PdfColors.grey300, width: 1),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(label, style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: PdfColors.grey600)),
          pw.SizedBox(height: 4),
          pw.Text(valor, style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold, color: PdfColors.orange900)),
          pw.SizedBox(height: 4),
          pw.Text(descricao, style: pw.TextStyle(fontSize: 7.5, color: PdfColors.grey500)),
        ],
      ),
    );
  }

  static pw.Widget _buildDistribuicaoCardProfessional(String label, String valor, PdfColor cor, String detalhe) {
    return pw.Container(
      width: 165,
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        border: pw.Border(left: pw.BorderSide(color: cor, width: 4)),
        color: PdfColors.grey50,
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(label, style: pw.TextStyle(fontSize: 8.5, fontWeight: pw.FontWeight.bold, color: PdfColors.grey800)),
              pw.Text(valor, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: cor)),
            ],
          ),
          pw.SizedBox(height: 3),
          pw.Text(detalhe, style: pw.TextStyle(fontSize: 7, color: PdfColors.grey500)),
        ],
      ),
    );
  }

  static String _formatarData(DateTime data) {
    final dias = ['Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado', 'Domingo'];
    final meses = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'];
    return '${dias[data.weekday - 1]}, ${data.day} de ${meses[data.month - 1]}';
  }

  static String _getStatusAlimento(double taxa) {
    if (taxa >= 80) return 'Aceitação Alta';
    if (taxa >= 40) return 'Aceitação Parcial';
    return 'Recusa Sensorial';
  }

  static PdfColor _getCorStatusAlimento(double taxa) {
    if (taxa >= 80) return PdfColors.green700;
    if (taxa >= 40) return PdfColors.amber700;
    return PdfColors.red700;
  }

  /// Gera um insight terapêutico preditivo com base na frequência e aceitação média
  static String _calcularDiretrizClinica(int frequencia, double aceitacaoGeral) {
    if (frequencia >= 4 && aceitacaoGeral >= 80) {
      return 'Item seguro consolidado no repertório alimentar da criança.';
    }
    if (frequencia >= 4 && aceitacaoGeral < 40) {
      return 'Recusa Crônica Persistente. Alerta de hipersensibilidade ou aversão ativa.';
    }
    if (frequencia < 3 && aceitacaoGeral >= 50) {
      return 'Janela de oportunidade favorável. Aumentar frequência de oferta.';
    }
    if (aceitacaoGeral >= 40 && aceitacaoGeral < 80) {
      return 'Fase de acomodação sensorial positiva. Variar levemente o preparo.';
    }
    return 'Exposição insuficiente para estabelecer diagnóstico comportamental.';
  }
}