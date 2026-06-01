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

part 'criar_refeicao.dart';

part 'atualizar_refeicao.dart';

part 'deletar_refeicao.dart';

part 'marcar_refeicao_analisada.dart';

part 'rejeitar_refeicao.dart';

part 'obter_usuario_atual.dart';

part 'buscar_usuario_por_email.dart';

part 'obter_usuario_por_id.dart';

part 'contar_refeicoes_paciente.dart';

part 'listar_meus_pacientes.dart';

part 'obter_paciente_com_refeicoes.dart';

part 'obter_paciente_completo.dart';

part 'obter_paciente_para_nutricionista.dart';

part 'listar_refeicoes_paciente.dart';

part 'obter_refeicao_com_deteccoes.dart';

part 'listar_refeicoes_pendentes.dart';

part 'resumo_refeicoes7_dias.dart';







class ExampleConnector {
  
  
  CriarUsuarioVariablesBuilder criarUsuario ({required String id, required String nome, required String email, required String senhaHash, required String tipo, }) {
    return CriarUsuarioVariablesBuilder(dataConnect, id: id,nome: nome,email: email,senhaHash: senhaHash,tipo: tipo,);
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
  
  
  CriarRefeicaoVariablesBuilder criarRefeicao ({required String pacienteId, required String status, required String urlFotoAntes, required String urlFotoDepois, }) {
    return CriarRefeicaoVariablesBuilder(dataConnect, pacienteId: pacienteId,status: status,urlFotoAntes: urlFotoAntes,urlFotoDepois: urlFotoDepois,);
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
  
  
  ObterUsuarioAtualVariablesBuilder obterUsuarioAtual ({required String id, }) {
    return ObterUsuarioAtualVariablesBuilder(dataConnect, id: id,);
  }
  
  
  BuscarUsuarioPorEmailVariablesBuilder buscarUsuarioPorEmail ({required String email, }) {
    return BuscarUsuarioPorEmailVariablesBuilder(dataConnect, email: email,);
  }
  
  
  ObterUsuarioPorIdVariablesBuilder obterUsuarioPorId ({required String id, }) {
    return ObterUsuarioPorIdVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ContarRefeicoesPacienteVariablesBuilder contarRefeicoesPaciente ({required String pacienteId, }) {
    return ContarRefeicoesPacienteVariablesBuilder(dataConnect, pacienteId: pacienteId,);
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
  
  
  ResumoRefeicoes7DiasVariablesBuilder resumoRefeicoes7Dias ({required String pacienteId, required Timestamp dataLimite, }) {
    return ResumoRefeicoes7DiasVariablesBuilder(dataConnect, pacienteId: pacienteId,dataLimite: dataLimite,);
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
