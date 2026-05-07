part of 'generated.dart';

class ListarRelatorioPacienteVariablesBuilder {
  String pacienteId;
  Optional<int> _limite = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  ListarRelatorioPacienteVariablesBuilder limite(int? t) {
   _limite.value = t;
   return this;
  }

  ListarRelatorioPacienteVariablesBuilder(this._dataConnect, {required  this.pacienteId,});
  Deserializer<ListarRelatorioPacienteData> dataDeserializer = (dynamic json)  => ListarRelatorioPacienteData.fromJson(jsonDecode(json));
  Serializer<ListarRelatorioPacienteVariables> varsSerializer = (ListarRelatorioPacienteVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListarRelatorioPacienteData, ListarRelatorioPacienteVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListarRelatorioPacienteData, ListarRelatorioPacienteVariables> ref() {
    ListarRelatorioPacienteVariables vars= ListarRelatorioPacienteVariables(pacienteId: pacienteId,limite: _limite,);
    return _dataConnect.query("ListarRelatorioPaciente", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListarRelatorioPacienteRelatorios {
  final String id;
  final String conteudo;
  final Timestamp dataGeracao;
  final ListarRelatorioPacienteRelatoriosRefeicao refeicao;
  ListarRelatorioPacienteRelatorios.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  conteudo = nativeFromJson<String>(json['conteudo']),
  dataGeracao = Timestamp.fromJson(json['dataGeracao']),
  refeicao = ListarRelatorioPacienteRelatoriosRefeicao.fromJson(json['refeicao']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarRelatorioPacienteRelatorios otherTyped = other as ListarRelatorioPacienteRelatorios;
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

  ListarRelatorioPacienteRelatorios({
    required this.id,
    required this.conteudo,
    required this.dataGeracao,
    required this.refeicao,
  });
}

@immutable
class ListarRelatorioPacienteRelatoriosRefeicao {
  final String id;
  final Timestamp dataHora;
  final String urlFotoAntes;
  ListarRelatorioPacienteRelatoriosRefeicao.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
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

    final ListarRelatorioPacienteRelatoriosRefeicao otherTyped = other as ListarRelatorioPacienteRelatoriosRefeicao;
    return id == otherTyped.id && 
    dataHora == otherTyped.dataHora && 
    urlFotoAntes == otherTyped.urlFotoAntes;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, dataHora.hashCode, urlFotoAntes.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['dataHora'] = dataHora.toJson();
    json['urlFotoAntes'] = nativeToJson<String>(urlFotoAntes);
    return json;
  }

  ListarRelatorioPacienteRelatoriosRefeicao({
    required this.id,
    required this.dataHora,
    required this.urlFotoAntes,
  });
}

@immutable
class ListarRelatorioPacienteData {
  final List<ListarRelatorioPacienteRelatorios> relatorios;
  ListarRelatorioPacienteData.fromJson(dynamic json):
  
  relatorios = (json['relatorios'] as List<dynamic>)
        .map((e) => ListarRelatorioPacienteRelatorios.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarRelatorioPacienteData otherTyped = other as ListarRelatorioPacienteData;
    return relatorios == otherTyped.relatorios;
    
  }
  @override
  int get hashCode => relatorios.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['relatorios'] = relatorios.map((e) => e.toJson()).toList();
    return json;
  }

  ListarRelatorioPacienteData({
    required this.relatorios,
  });
}

@immutable
class ListarRelatorioPacienteVariables {
  final String pacienteId;
  late final Optional<int>limite;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListarRelatorioPacienteVariables.fromJson(Map<String, dynamic> json):
  
  pacienteId = nativeFromJson<String>(json['pacienteId']) {
  
  
  
    limite = Optional.optional(nativeFromJson, nativeToJson);
    limite.value = json['limite'] == null ? null : nativeFromJson<int>(json['limite']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarRelatorioPacienteVariables otherTyped = other as ListarRelatorioPacienteVariables;
    return pacienteId == otherTyped.pacienteId && 
    limite == otherTyped.limite;
    
  }
  @override
  int get hashCode => Object.hashAll([pacienteId.hashCode, limite.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['pacienteId'] = nativeToJson<String>(pacienteId);
    if(limite.state == OptionalState.set) {
      json['limite'] = limite.toJson();
    }
    return json;
  }

  ListarRelatorioPacienteVariables({
    required this.pacienteId,
    required this.limite,
  });
}

