part of 'generated.dart';

class ListarRefeicoesPendentesVariablesBuilder {
  String pacienteId;

  final FirebaseDataConnect _dataConnect;
  ListarRefeicoesPendentesVariablesBuilder(this._dataConnect, {required  this.pacienteId,});
  Deserializer<ListarRefeicoesPendentesData> dataDeserializer = (dynamic json)  => ListarRefeicoesPendentesData.fromJson(jsonDecode(json));
  Serializer<ListarRefeicoesPendentesVariables> varsSerializer = (ListarRefeicoesPendentesVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListarRefeicoesPendentesData, ListarRefeicoesPendentesVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListarRefeicoesPendentesData, ListarRefeicoesPendentesVariables> ref() {
    ListarRefeicoesPendentesVariables vars= ListarRefeicoesPendentesVariables(pacienteId: pacienteId,);
    return _dataConnect.query("ListarRefeicoesPendentes", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListarRefeicoesPendentesRefeicaos {
  final String id;
  final Timestamp dataHora;
  final String urlFotoAntes;
  final ListarRefeicoesPendentesRefeicaosPaciente paciente;
  ListarRefeicoesPendentesRefeicaos.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  dataHora = Timestamp.fromJson(json['dataHora']),
  urlFotoAntes = nativeFromJson<String>(json['urlFotoAntes']),
  paciente = ListarRefeicoesPendentesRefeicaosPaciente.fromJson(json['paciente']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarRefeicoesPendentesRefeicaos otherTyped = other as ListarRefeicoesPendentesRefeicaos;
    return id == otherTyped.id && 
    dataHora == otherTyped.dataHora && 
    urlFotoAntes == otherTyped.urlFotoAntes && 
    paciente == otherTyped.paciente;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, dataHora.hashCode, urlFotoAntes.hashCode, paciente.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['dataHora'] = dataHora.toJson();
    json['urlFotoAntes'] = nativeToJson<String>(urlFotoAntes);
    json['paciente'] = paciente.toJson();
    return json;
  }

  ListarRefeicoesPendentesRefeicaos({
    required this.id,
    required this.dataHora,
    required this.urlFotoAntes,
    required this.paciente,
  });
}

@immutable
class ListarRefeicoesPendentesRefeicaosPaciente {
  final String nome;
  ListarRefeicoesPendentesRefeicaosPaciente.fromJson(dynamic json):
  
  nome = nativeFromJson<String>(json['nome']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarRefeicoesPendentesRefeicaosPaciente otherTyped = other as ListarRefeicoesPendentesRefeicaosPaciente;
    return nome == otherTyped.nome;
    
  }
  @override
  int get hashCode => nome.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nome'] = nativeToJson<String>(nome);
    return json;
  }

  ListarRefeicoesPendentesRefeicaosPaciente({
    required this.nome,
  });
}

@immutable
class ListarRefeicoesPendentesData {
  final List<ListarRefeicoesPendentesRefeicaos> refeicaos;
  ListarRefeicoesPendentesData.fromJson(dynamic json):
  
  refeicaos = (json['refeicaos'] as List<dynamic>)
        .map((e) => ListarRefeicoesPendentesRefeicaos.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarRefeicoesPendentesData otherTyped = other as ListarRefeicoesPendentesData;
    return refeicaos == otherTyped.refeicaos;
    
  }
  @override
  int get hashCode => refeicaos.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['refeicaos'] = refeicaos.map((e) => e.toJson()).toList();
    return json;
  }

  ListarRefeicoesPendentesData({
    required this.refeicaos,
  });
}

@immutable
class ListarRefeicoesPendentesVariables {
  final String pacienteId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListarRefeicoesPendentesVariables.fromJson(Map<String, dynamic> json):
  
  pacienteId = nativeFromJson<String>(json['pacienteId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarRefeicoesPendentesVariables otherTyped = other as ListarRefeicoesPendentesVariables;
    return pacienteId == otherTyped.pacienteId;
    
  }
  @override
  int get hashCode => pacienteId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['pacienteId'] = nativeToJson<String>(pacienteId);
    return json;
  }

  ListarRefeicoesPendentesVariables({
    required this.pacienteId,
  });
}

