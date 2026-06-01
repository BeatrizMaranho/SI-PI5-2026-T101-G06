import 'package:flutter/material.dart';

class AlimentoModel {
  final String nome;
  final String porcentagem;

  AlimentoModel({
    required this.nome,
    required this.porcentagem,
  });
}

class RefeicaoModel {
  static String? idCriancaAtiva;
  static String? nomeCriancaAtiva;

  final String pacienteNome; 
  final DateTime data;       
  final List<AlimentoModel> alimentos;
  final String fotoAntes;    
  final String fotoDepois;

  RefeicaoModel({
    required this.pacienteNome,
    required this.data,
    required this.alimentos,
    this.fotoAntes = "",
    this.fotoDepois = "",
  });

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

class RefeicaoProvider with ChangeNotifier {
  final List<RefeicaoModel> _historico = [];
  String? _idCriancaAtiva;
  String? _nomeCriancaAtiva;

  List<RefeicaoModel> get historico => _historico;
  String? get idCriancaAtiva => _idCriancaAtiva;
  String? get nomeCriancaAtiva => _nomeCriancaAtiva;

  void selecionarCrianca(String id, String nome) {
    _idCriancaAtiva = id;
    _nomeCriancaAtiva = nome;
    notifyListeners();
  }

  void salvarRefeicao(RefeicaoModel refeicao) {
    _historico.insert(0, refeicao); 
    notifyListeners(); 
  }

  List<RefeicaoModel> filtrarPorPeriodo(int dias) {
    if (dias == 0) return _historico;
    final limite = DateTime.now().subtract(Duration(days: dias));
    return _historico.where((r) => r.data.isAfter(limite)).toList();
  }
}