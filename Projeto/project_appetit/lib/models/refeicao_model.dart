import 'package:flutter/material.dart';

// --- 1. MODELO DE ALIMENTO ---
// Representa cada item identificado pela IA (ex: Arroz, 80%)
class AlimentoModel {
  final String nome;
  final String porcentagem;

  AlimentoModel({
    required this.nome,
    required this.porcentagem,
  });
}

// --- 2. MODELO DE REFEIÇÃO ---
// Representa a análise completa de um prato vinculada a uma criança
class RefeicaoModel {
  // === VARIÁVEIS ESTÁTICAS PARA PERSISTIR A CRIANÇA ATIVA ENTRE AS ABAS ===
  static String? idCriancaAtiva;
  static String? nomeCriancaAtiva;

  final String pacienteNome; // Nome da criança vinculada
  final DateTime data;       // Data para os filtros do dashboard
  final List<AlimentoModel> alimentos;
  final String fotoAntes;    // Path ou Base64 da imagem
  final String fotoDepois;

  RefeicaoModel({
    required this.pacienteNome,
    required this.data,
    required this.alimentos,
    this.fotoAntes = "",
    this.fotoDepois = "",
  });

  // --- GETTERS DE RESUMO ---
  // Convertem a string "80%" em número para lógica de aceitação
  int get bemAceitos => alimentos.where((a) {
        final valor = int.tryParse(a.porcentagem.replaceAll('%', '')) ?? 0;
        return valor >= 80;
      }).length;

  int get parciais => alimentos.where((a) {
        final valor = int.tryParse(a.porcentagem.replaceAll('%', '')) ?? 0;
        return valor >= 40 && valor < 80;
      }).length;

  int get rejeitados => alimentos.where((a) {
        final valor = int.tryParse(a.porcentagem.replaceAll('%', '')) ?? 0;
        return valor < 40;
      }).length;
}

// --- 3. PROVIDER (GERENCIADOR DE ESTADO) ---
// Mantém o histórico em memória e notifica o Dashboard sobre novas análises
class RefeicaoProvider with ChangeNotifier {
  final List<RefeicaoModel> _historico = [];

  List<RefeicaoModel> get historico => _historico;

  // Chamado no botão "Concluído" do seu Pop-up
  void salvarRefeicao(RefeicaoModel refeicao) {
    _historico.insert(0, refeicao); // Adiciona no topo da lista (mais recente primeiro)
    notifyListeners(); // Faz o Dashboard atualizar na hora
  }

  // Lógica de filtro por dias (Hoje = 1, 7 dias = 7, etc.)
  List<RefeicaoModel> filtrarPorPeriodo(int dias) {
    if (dias == 0) return _historico;
    
    // Define a data de corte (ex: agora menos 7 dias)
    final limite = DateTime.now().subtract(Duration(days: dias));
    
    return _historico.where((r) => r.data.isAfter(limite)).toList();
  }
}