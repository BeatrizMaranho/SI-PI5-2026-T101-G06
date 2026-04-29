library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'criar_usuario.dart';

part 'deletar_usuario.dart';

part 'atualizar_perfil.dart';

part 'atualizar_senha.dart';

part 'criar_paciente.dart';

part 'atualizar_paciente.dart';

part 'deletar_paciente.dart';

part 'vincular_nutricionista.dart';

part 'desvincular_nutricionista.dart';

part 'vincular_nutricionista_com_paciente.dart';

part 'criar_refeicao.dart';

part 'atualizar_refeicao.dart';

part 'deletar_refeicao.dart';

part 'marcar_refeicao_analisada.dart';

part 'rejeitar_refeicao.dart';

part 'criar_deteccao.dart';

part 'atualizar_deteccao.dart';

part 'deletar_deteccao.dart';

part 'criar_alimento.dart';

part 'atualizar_alimento.dart';

part 'deletar_alimento.dart';

part 'criar_relatorio.dart';

part 'atualizar_relatorio.dart';

part 'deletar_relatorio.dart';

part 'obter_usuario_atual.dart';

part 'buscar_usuario_por_email.dart';

part 'obter_usuario_por_id.dart';

part 'listar_meus_pacientes.dart';

part 'obter_paciente_com_refeicoes.dart';

part 'obter_paciente_completo.dart';

part 'listar_pacientes_vinculados.dart';

part 'obter_paciente_para_nutricionista.dart';

part 'listar_refeicoes_paciente.dart';

part 'obter_refeicao_com_deteccoes.dart';

part 'listar_refeicoes_pendentes.dart';

part 'listar_deteccoes_por_refeicao.dart';

part 'listar_deteccoes_aceitas_por_refeicao.dart';

part 'obter_relatorio_por_refeicao.dart';

part 'listar_relatorio_paciente.dart';

part 'obter_relatorio_completo.dart';

part 'listar_catalogo_alimentos.dart';

part 'buscar_alimento_por_label.dart';

part 'listar_alimentos_por_categoria.dart';

part 'resumo_refeicoes7_dias.dart';

part 'alimentos_mais_detectados.dart';







class ExampleConnector {
  
  
  CriarUsuarioVariablesBuilder criarUsuario ({required String nome, required String email, required String senhaHash, required String tipo, }) {
    return CriarUsuarioVariablesBuilder(dataConnect, nome: nome,email: email,senhaHash: senhaHash,tipo: tipo,);
  }
  
  
  DeletarUsuarioVariablesBuilder deletarUsuario ({required String id, }) {
    return DeletarUsuarioVariablesBuilder(dataConnect, id: id,);
  }
  
  
  AtualizarPerfilVariablesBuilder atualizarPerfil ({required String id, }) {
    return AtualizarPerfilVariablesBuilder(dataConnect, id: id,);
  }
  
  
  AtualizarSenhaVariablesBuilder atualizarSenha ({required String id, required String senhaHashNova, }) {
    return AtualizarSenhaVariablesBuilder(dataConnect, id: id,senhaHashNova: senhaHashNova,);
  }
  
  
  CriarPacienteVariablesBuilder criarPaciente ({required String nome, required String responsavelId, }) {
    return CriarPacienteVariablesBuilder(dataConnect, nome: nome,responsavelId: responsavelId,);
  }
  
  
  AtualizarPacienteVariablesBuilder atualizarPaciente ({required String id, }) {
    return AtualizarPacienteVariablesBuilder(dataConnect, id: id,);
  }
  
  
  DeletarPacienteVariablesBuilder deletarPaciente ({required String id, }) {
    return DeletarPacienteVariablesBuilder(dataConnect, id: id,);
  }
  
  
  VincularNutricionistaVariablesBuilder vincularNutricionista ({required String nutricionistaId, required String pacienteId, }) {
    return VincularNutricionistaVariablesBuilder(dataConnect, nutricionistaId: nutricionistaId,pacienteId: pacienteId,);
  }
  
  
  DesvincularNutricionistaVariablesBuilder desvincularNutricionista ({required String nutricionistaId, required String pacienteId, }) {
    return DesvincularNutricionistaVariablesBuilder(dataConnect, nutricionistaId: nutricionistaId,pacienteId: pacienteId,);
  }
  
  
  VincularNutricionistaComPacienteVariablesBuilder vincularNutricionistaComPaciente ({required String nutricionistaId, required String pacienteId, }) {
    return VincularNutricionistaComPacienteVariablesBuilder(dataConnect, nutricionistaId: nutricionistaId,pacienteId: pacienteId,);
  }
  
  
  CriarRefeicaoVariablesBuilder criarRefeicao ({required String pacienteId, required String urlFotoAntes, }) {
    return CriarRefeicaoVariablesBuilder(dataConnect, pacienteId: pacienteId,urlFotoAntes: urlFotoAntes,);
  }
  
  
  AtualizarRefeicaoVariablesBuilder atualizarRefeicao ({required String id, }) {
    return AtualizarRefeicaoVariablesBuilder(dataConnect, id: id,);
  }
  
  
  DeletarRefeicaoVariablesBuilder deletarRefeicao ({required String id, }) {
    return DeletarRefeicaoVariablesBuilder(dataConnect, id: id,);
  }
  
  
  MarcarRefeicaoAnalisadaVariablesBuilder marcarRefeicaoAnalisada ({required String id, }) {
    return MarcarRefeicaoAnalisadaVariablesBuilder(dataConnect, id: id,);
  }
  
  
  RejeitarRefeicaoVariablesBuilder rejeitarRefeicao ({required String id, }) {
    return RejeitarRefeicaoVariablesBuilder(dataConnect, id: id,);
  }
  
  
  CriarDeteccaoVariablesBuilder criarDeteccao ({required String refeicaoId, required String alimentoId, required double confidence, required double percentualConsumido, }) {
    return CriarDeteccaoVariablesBuilder(dataConnect, refeicaoId: refeicaoId,alimentoId: alimentoId,confidence: confidence,percentualConsumido: percentualConsumido,);
  }
  
  
  AtualizarDeteccaoVariablesBuilder atualizarDeteccao ({required String id, required bool aceito, }) {
    return AtualizarDeteccaoVariablesBuilder(dataConnect, id: id,aceito: aceito,);
  }
  
  
  DeletarDeteccaoVariablesBuilder deletarDeteccao ({required String id, }) {
    return DeletarDeteccaoVariablesBuilder(dataConnect, id: id,);
  }
  
  
  CriarAlimentoVariablesBuilder criarAlimento ({required String label, }) {
    return CriarAlimentoVariablesBuilder(dataConnect, label: label,);
  }
  
  
  AtualizarAlimentoVariablesBuilder atualizarAlimento ({required String id, }) {
    return AtualizarAlimentoVariablesBuilder(dataConnect, id: id,);
  }
  
  
  DeletarAlimentoVariablesBuilder deletarAlimento ({required String id, }) {
    return DeletarAlimentoVariablesBuilder(dataConnect, id: id,);
  }
  
  
  CriarRelatorioVariablesBuilder criarRelatorio ({required String refeicaoId, required String pacienteId, required String conteudo, }) {
    return CriarRelatorioVariablesBuilder(dataConnect, refeicaoId: refeicaoId,pacienteId: pacienteId,conteudo: conteudo,);
  }
  
  
  AtualizarRelatorioVariablesBuilder atualizarRelatorio ({required String id, required String conteudo, }) {
    return AtualizarRelatorioVariablesBuilder(dataConnect, id: id,conteudo: conteudo,);
  }
  
  
  DeletarRelatorioVariablesBuilder deletarRelatorio ({required String id, }) {
    return DeletarRelatorioVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ObterUsuarioAtualVariablesBuilder obterUsuarioAtual ({required String id, }) {
    return ObterUsuarioAtualVariablesBuilder(dataConnect, id: id,);
  }
  
  
  BuscarUsuarioPorEmailVariablesBuilder buscarUsuarioPorEmail ({required String email, }) {
    return BuscarUsuarioPorEmailVariablesBuilder(dataConnect, email: email,);
  }
  
  
  ObterUsuarioPorIdVariablesBuilder obterUsuarioPorId ({required String id, }) {
    return ObterUsuarioPorIdVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListarMeusPacientesVariablesBuilder listarMeusPacientes ({required String responsavelId, }) {
    return ListarMeusPacientesVariablesBuilder(dataConnect, responsavelId: responsavelId,);
  }
  
  
  ObterPacienteComRefeicoesVariablesBuilder obterPacienteComRefeicoes ({required String pacienteId, }) {
    return ObterPacienteComRefeicoesVariablesBuilder(dataConnect, pacienteId: pacienteId,);
  }
  
  
  ObterPacienteCompletoVariablesBuilder obterPacienteCompleto ({required String pacienteId, }) {
    return ObterPacienteCompletoVariablesBuilder(dataConnect, pacienteId: pacienteId,);
  }
  
  
  ListarPacientesVinculadosVariablesBuilder listarPacientesVinculados ({required String nutricionistaId, }) {
    return ListarPacientesVinculadosVariablesBuilder(dataConnect, nutricionistaId: nutricionistaId,);
  }
  
  
  ObterPacienteParaNutricionistaVariablesBuilder obterPacienteParaNutricionista ({required String pacienteId, }) {
    return ObterPacienteParaNutricionistaVariablesBuilder(dataConnect, pacienteId: pacienteId,);
  }
  
  
  ListarRefeicoesPacienteVariablesBuilder listarRefeicoesPaciente ({required String pacienteId, }) {
    return ListarRefeicoesPacienteVariablesBuilder(dataConnect, pacienteId: pacienteId,);
  }
  
  
  ObterRefeicaoComDeteccoesVariablesBuilder obterRefeicaoComDeteccoes ({required String refeicaoId, }) {
    return ObterRefeicaoComDeteccoesVariablesBuilder(dataConnect, refeicaoId: refeicaoId,);
  }
  
  
  ListarRefeicoesPendentesVariablesBuilder listarRefeicoesPendentes ({required String pacienteId, }) {
    return ListarRefeicoesPendentesVariablesBuilder(dataConnect, pacienteId: pacienteId,);
  }
  
  
  ListarDeteccoesPorRefeicaoVariablesBuilder listarDeteccoesPorRefeicao ({required String refeicaoId, }) {
    return ListarDeteccoesPorRefeicaoVariablesBuilder(dataConnect, refeicaoId: refeicaoId,);
  }
  
  
  ListarDeteccoesAceitasPorRefeicaoVariablesBuilder listarDeteccoesAceitasPorRefeicao ({required String refeicaoId, }) {
    return ListarDeteccoesAceitasPorRefeicaoVariablesBuilder(dataConnect, refeicaoId: refeicaoId,);
  }
  
  
  ObterRelatorioPorRefeicaoVariablesBuilder obterRelatorioPorRefeicao ({required String refeicaoId, }) {
    return ObterRelatorioPorRefeicaoVariablesBuilder(dataConnect, refeicaoId: refeicaoId,);
  }
  
  
  ListarRelatorioPacienteVariablesBuilder listarRelatorioPaciente ({required String pacienteId, }) {
    return ListarRelatorioPacienteVariablesBuilder(dataConnect, pacienteId: pacienteId,);
  }
  
  
  ObterRelatorioCompletoVariablesBuilder obterRelatorioCompleto ({required String relatorioId, }) {
    return ObterRelatorioCompletoVariablesBuilder(dataConnect, relatorioId: relatorioId,);
  }
  
  
  ListarCatalogoAlimentosVariablesBuilder listarCatalogoAlimentos () {
    return ListarCatalogoAlimentosVariablesBuilder(dataConnect, );
  }
  
  
  BuscarAlimentoPorLabelVariablesBuilder buscarAlimentoPorLabel ({required String label, }) {
    return BuscarAlimentoPorLabelVariablesBuilder(dataConnect, label: label,);
  }
  
  
  ListarAlimentosPorCategoriaVariablesBuilder listarAlimentosPorCategoria ({required String categoria, }) {
    return ListarAlimentosPorCategoriaVariablesBuilder(dataConnect, categoria: categoria,);
  }
  
  
  ResumoRefeicoes7DiasVariablesBuilder resumoRefeicoes7Dias ({required String pacienteId, required Timestamp dataLimite, }) {
    return ResumoRefeicoes7DiasVariablesBuilder(dataConnect, pacienteId: pacienteId,dataLimite: dataLimite,);
  }
  
  
  AlimentosMaisDetectadosVariablesBuilder alimentosMaisDetectados ({required String pacienteId, required Timestamp dataLimite, }) {
    return AlimentosMaisDetectadosVariablesBuilder(dataConnect, pacienteId: pacienteId,dataLimite: dataLimite,);
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'southamerica-east1',
    'example',
    'pi-v-appetit-service',
  );

  ExampleConnector({required this.dataConnect});
  static ExampleConnector get instance {
    
    CacheSettings cacheSettings = CacheSettings(
      maxAge: Duration(milliseconds:0),
      storage: CacheStorage.persistent,
    );
    
    return ExampleConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            
            cacheSettings: cacheSettings,
            
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
