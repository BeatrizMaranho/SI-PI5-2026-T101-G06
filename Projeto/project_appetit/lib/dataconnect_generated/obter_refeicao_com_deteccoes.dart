part of 'generated.dart';

class ObterRefeicaoComDeteccoesVariablesBuilder {
  String refeicaoId;

  final FirebaseDataConnect _dataConnect;
  ObterRefeicaoComDeteccoesVariablesBuilder(this._dataConnect, {required  this.refeicaoId,});
  Deserializer<ObterRefeicaoComDeteccoesData> dataDeserializer = (dynamic json)  => ObterRefeicaoComDeteccoesData.fromJson(jsonDecode(json));
  Serializer<ObterRefeicaoComDeteccoesVariables> varsSerializer = (ObterRefeicaoComDeteccoesVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ObterRefeicaoComDeteccoesData, ObterRefeicaoComDeteccoesVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ObterRefeicaoComDeteccoesData, ObterRefeicaoComDeteccoesVariables> ref() {
    ObterRefeicaoComDeteccoesVariables vars= ObterRefeicaoComDeteccoesVariables(refeicaoId: refeicaoId,);
    return _dataConnect.query("ObterRefeicaoComDeteccoes", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ObterRefeicaoComDeteccoesRefeicao {
  final String id;
  final Timestamp dataHora;
  final String status;
  final String urlFotoAntes;
  final String? urlFotoDepois;
  final String? analise;
  final ObterRefeicaoComDeteccoesRefeicaoPaciente paciente;
  ObterRefeicaoComDeteccoesRefeicao.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  dataHora = Timestamp.fromJson(json['dataHora']),
  status = nativeFromJson<String>(json['status']),
  urlFotoAntes = nativeFromJson<String>(json['urlFotoAntes']),
  urlFotoDepois = json['urlFotoDepois'] == null ? null : nativeFromJson<String>(json['urlFotoDepois']),
  analise = json['analise'] == null ? null : nativeFromJson<String>(json['analise']),
  paciente = ObterRefeicaoComDeteccoesRefeicaoPaciente.fromJson(json['paciente']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterRefeicaoComDeteccoesRefeicao otherTyped = other as ObterRefeicaoComDeteccoesRefeicao;
    return id == otherTyped.id && 
    dataHora == otherTyped.dataHora && 
    status == otherTyped.status && 
    urlFotoAntes == otherTyped.urlFotoAntes && 
    urlFotoDepois == otherTyped.urlFotoDepois && 
    analise == otherTyped.analise && 
    paciente == otherTyped.paciente;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, dataHora.hashCode, status.hashCode, urlFotoAntes.hashCode, urlFotoDepois.hashCode, analise.hashCode, paciente.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['dataHora'] = dataHora.toJson();
    json['status'] = nativeToJson<String>(status);
    json['urlFotoAntes'] = nativeToJson<String>(urlFotoAntes);
    if (urlFotoDepois != null) {
      json['urlFotoDepois'] = nativeToJson<String?>(urlFotoDepois);
    }
    if (analise != null) {
      json['analise'] = nativeToJson<String?>(analise);
    }
    json['paciente'] = paciente.toJson();
    return json;
  }

  ObterRefeicaoComDeteccoesRefeicao({
    required this.id,
    required this.dataHora,
    required this.status,
    required this.urlFotoAntes,
    this.urlFotoDepois,
    this.analise,
    required this.paciente,
  });
}

@immutable
class ObterRefeicaoComDeteccoesRefeicaoPaciente {
  final String nome;
  ObterRefeicaoComDeteccoesRefeicaoPaciente.fromJson(dynamic json):
  
  nome = nativeFromJson<String>(json['nome']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterRefeicaoComDeteccoesRefeicaoPaciente otherTyped = other as ObterRefeicaoComDeteccoesRefeicaoPaciente;
    return nome == otherTyped.nome;
    
  }
  @override
  int get hashCode => nome.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nome'] = nativeToJson<String>(nome);
    return json;
  }

  ObterRefeicaoComDeteccoesRefeicaoPaciente({
    required this.nome,
  });
}

@immutable
class ObterRefeicaoComDeteccoesData {
  final ObterRefeicaoComDeteccoesRefeicao? refeicao;
  ObterRefeicaoComDeteccoesData.fromJson(dynamic json):
  
  refeicao = json['refeicao'] == null ? null : ObterRefeicaoComDeteccoesRefeicao.fromJson(json['refeicao']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterRefeicaoComDeteccoesData otherTyped = other as ObterRefeicaoComDeteccoesData;
    return refeicao == otherTyped.refeicao;
    
  }
  @override
  int get hashCode => refeicao.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (refeicao != null) {
      json['refeicao'] = refeicao!.toJson();
    }
    return json;
  }

  ObterRefeicaoComDeteccoesData({
    this.refeicao,
  });
}

@immutable
class ObterRefeicaoComDeteccoesVariables {
  final String refeicaoId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ObterRefeicaoComDeteccoesVariables.fromJson(Map<String, dynamic> json):
  
  refeicaoId = nativeFromJson<String>(json['refeicaoId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterRefeicaoComDeteccoesVariables otherTyped = other as ObterRefeicaoComDeteccoesVariables;
    return refeicaoId == otherTyped.refeicaoId;
    
  }
  @override
  int get hashCode => refeicaoId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['refeicaoId'] = nativeToJson<String>(refeicaoId);
    return json;
  }

  ObterRefeicaoComDeteccoesVariables({
    required this.refeicaoId,
  });
}

