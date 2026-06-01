import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:project_appetit/dataconnect_generated/generated.dart';

class AlimentoModel {
  final String nome;
  final String porcentagem;
  AlimentoModel({required this.nome, required this.porcentagem});
}

class RefeicaoModel {
  final String id;
  final String pacienteNome;
  final DateTime data;
  final List<AlimentoModel> alimentos;
  final String fotoAntes;
  final String? fotoDepois;
  RefeicaoModel({
    required this.id,
    required this.pacienteNome,
    required this.data,
    required this.alimentos,
    this.fotoAntes = "",
    this.fotoDepois,
  });
  static List<AlimentoModel> _parseAnalise(String? analise) {
    if (analise == null || analise.isEmpty) return [];
    try {
      final List<dynamic> lista = jsonDecode(analise);
      return lista.map((item) {
        final double porc = (item['porcentagem_consumida'] as num).toDouble();
        return AlimentoModel(
          nome: item['alimento'].toString(),
          porcentagem: "${porc.toInt()}%",
        );
      }).toList();
    } catch (_) {
      return [];
    }
  }

  factory RefeicaoModel.fromBanco({
    required String id,
    required DateTime dataHora,
    required String pacienteNome,
    required String urlFotoAntes,
    String? urlFotoDepois,
    String? analise,
  }) {
    return RefeicaoModel(
      id: id,
      pacienteNome: pacienteNome,
      data: dataHora,
      alimentos: _parseAnalise(analise),
      fotoAntes: urlFotoAntes,
      fotoDepois: urlFotoDepois,
    );
  }
  int get bemAceitos => alimentos.where((a) {
    final valor = int.tryParse(a.porcentagem.replaceAll('%', '').trim()) ?? 0;
    return valor >= 80;
  }).length;
  int get parciais => alimentos.where((a) {
    final valor = int.tryParse(a.porcentagem.replaceAll('%', '').trim()) ?? 0;
    return valor >= 40 && valor < 80;
  }).length;
  int get rejeitados => alimentos.where((a) {
    final valor = int.tryParse(a.porcentagem.replaceAll('%', '').trim()) ?? 0;
    return valor < 40;
  }).length;
}

class RefeicaoProvider with ChangeNotifier {
  List<RefeicaoModel> _refeicoes = [];
  bool _carregando = false;
  String? _ultimoPacienteId;
  List<RefeicaoModel> get historico => _refeicoes;
  bool get carregando => _carregando;
  List<RefeicaoModel> filtrarPorPeriodo(int dias) {
    if (dias == 0) return _refeicoes;
    final limite = DateTime.now().subtract(Duration(days: dias));
    return _refeicoes.where((r) => r.data.isAfter(limite)).toList();
  }

  Future<void> carregarRefeicoes(String pacienteId) async {
    if (_carregando) return;
    _carregando = true;
    _ultimoPacienteId = pacienteId;
    notifyListeners();
    print(
      "[REFEICAO_PROVIDER] Carregando refeições para pacienteId: $pacienteId",
    );
    try {
      final listaResult = await ExampleConnector.instance
          .listarRefeicoesPaciente(pacienteId: pacienteId)
          .execute(fetchPolicy: QueryFetchPolicy.serverOnly);
      print(
        "[REFEICAO_PROVIDER] Refeições encontradas: ${listaResult.data.refeicaos.length}",
      );
      final List<RefeicaoModel> resultado = [];
      for (final refeicao in listaResult.data.refeicaos) {
        try {
          final detalheResult = await ExampleConnector.instance
              .obterRefeicaoComDeteccoes(refeicaoId: refeicao.id)
              .execute(fetchPolicy: QueryFetchPolicy.serverOnly);
          final detalhe = detalheResult.data.refeicao;
          if (detalhe == null) continue;
          resultado.add(
            RefeicaoModel.fromBanco(
              id: detalhe.id,
              dataHora: DateTime.fromMillisecondsSinceEpoch(
                detalhe.dataHora.seconds * 1000,
              ),
              pacienteNome: detalhe.paciente.nome,
              urlFotoAntes: detalhe.urlFotoAntes,
              urlFotoDepois: detalhe.urlFotoDepois,
              analise: detalhe.analise,
            ),
          );
        } catch (e, stack) {
          print(
            "[REFEICAO_PROVIDER] Erro ao buscar detalhe ${refeicao.id}: $e\n$stack",
          );
        }
      }
      _refeicoes = resultado;
      print("[REFEICAO_PROVIDER] Total carregado: ${_refeicoes.length}");
    } catch (e, stack) {
      print("[REFEICAO_PROVIDER] Erro ao carregar refeições: $e\n$stack");
      _refeicoes = [];
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  Future<void> recarregar() async {
    if (_ultimoPacienteId != null) {
      await carregarRefeicoes(_ultimoPacienteId!);
    }
  }
}
