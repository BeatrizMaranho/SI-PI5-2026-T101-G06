part of 'generated.dart';

class ObterRelatorioPorRefeicaoVariablesBuilder {
  String refeicaoId;

  final FirebaseDataConnect _dataConnect;
  ObterRelatorioPorRefeicaoVariablesBuilder(this._dataConnect, {required  this.refeicaoId,});
  Deserializer<ObterRelatorioPorRefeicaoData> dataDeserializer = (dynamic json)  => ObterRelatorioPorRefeicaoData.fromJson(jsonDecode(json));
  Serializer<ObterRelatorioPorRefeicaoVariables> varsSerializer = (ObterRelatorioPorRefeicaoVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ObterRelatorioPorRefeicaoData, ObterRelatorioPorRefeicaoVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ObterRelatorioPorRefeicaoData, ObterRelatorioPorRefeicaoVariables> ref() {
    ObterRelatorioPorRefeicaoVariables vars= ObterRelatorioPorRefeicaoVariables(refeicaoId: refeicaoId,);
    return _dataConnect.query("ObterRelatorioPorRefeicao", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ObterRelatorioPorRefeicaoRelatorios {
  final String id;
  final String conteudo;
  final Timestamp dataGeracao;
  final ObterRelatorioPorRefeicaoRelatoriosRefeicao refeicao;
  ObterRelatorioPorRefeicaoRelatorios.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  conteudo = nativeFromJson<String>(json['conteudo']),
  dataGeracao = Timestamp.fromJson(json['dataGeracao']),
  refeicao = ObterRelatorioPorRefeicaoRelatoriosRefeicao.fromJson(json['refeicao']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterRelatorioPorRefeicaoRelatorios otherTyped = other as ObterRelatorioPorRefeicaoRelatorios;
    return id == otherTyped.id && 
    conteudo == otherTyped.conteudo && 
    dataGeracao == otherTyped.dataGeracao && 
    refeicao == otherTyped.refeicao;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, conteudo.hashCode, dataGeracao.hashCode, refeicao.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['conteudo'] = nativeToJson<String>(conteudo);
    json['dataGeracao'] = dataGeracao.toJson();
    json['refeicao'] = refeicao.toJson();
    return json;
  }

  ObterRelatorioPorRefeicaoRelatorios({
    required this.id,
    required this.conteudo,
    required this.dataGeracao,
    required this.refeicao,
  });
}

@immutable
class ObterRelatorioPorRefeicaoRelatoriosRefeicao {
  final Timestamp dataHora;
  final String urlFotoAntes;
  ObterRelatorioPorRefeicaoRelatoriosRefeicao.fromJson(dynamic json):
  
  dataHora = Timestamp.fromJson(json['dataHora']),
  urlFotoAntes = nativeFromJson<String>(json['urlFotoAntes']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterRelatorioPorRefeicaoRelatoriosRefeicao otherTyped = other as ObterRelatorioPorRefeicaoRelatoriosRefeicao;
    return dataHora == otherTyped.dataHora && 
    urlFotoAntes == otherTyped.urlFotoAntes;
    
  }
  @override
  int get hashCode => Object.hashAll([dataHora.hashCode, urlFotoAntes.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['dataHora'] = dataHora.toJson();
    json['urlFotoAntes'] = nativeToJson<String>(urlFotoAntes);
    return json;
  }

  ObterRelatorioPorRefeicaoRelatoriosRefeicao({
    required this.dataHora,
    required this.urlFotoAntes,
  });
}

@immutable
class ObterRelatorioPorRefeicaoData {
  final List<ObterRelatorioPorRefeicaoRelatorios> relatorios;
  ObterRelatorioPorRefeicaoData.fromJson(dynamic json):
  
  relatorios = (json['relatorios'] as List<dynamic>)
        .map((e) => ObterRelatorioPorRefeicaoRelatorios.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterRelatorioPorRefeicaoData otherTyped = other as ObterRelatorioPorRefeicaoData;
    return relatorios == otherTyped.relatorios;
    
  }
  @override
  int get hashCode => relatorios.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['relatorios'] = relatorios.map((e) => e.toJson()).toList();
    return json;
  }

  ObterRelatorioPorRefeicaoData({
    required this.relatorios,
  });
}

@immutable
class ObterRelatorioPorRefeicaoVariables {
  final String refeicaoId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ObterRelatorioPorRefeicaoVariables.fromJson(Map<String, dynamic> json):
  
  refeicaoId = nativeFromJson<String>(json['refeicaoId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterRelatorioPorRefeicaoVariables otherTyped = other as ObterRelatorioPorRefeicaoVariables;
    return refeicaoId == otherTyped.refeicaoId;
    
  }
  @override
  int get hashCode => refeicaoId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['refeicaoId'] = nativeToJson<String>(refeicaoId);
    return json;
  }

  ObterRelatorioPorRefeicaoVariables({
    required this.refeicaoId,
  });
}

