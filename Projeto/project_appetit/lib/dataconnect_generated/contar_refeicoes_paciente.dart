part of 'generated.dart';

class ContarRefeicoesPacienteVariablesBuilder {
  String pacienteId;

  final FirebaseDataConnect _dataConnect;
  ContarRefeicoesPacienteVariablesBuilder(this._dataConnect, {required  this.pacienteId,});
  Deserializer<ContarRefeicoesPacienteData> dataDeserializer = (dynamic json)  => ContarRefeicoesPacienteData.fromJson(jsonDecode(json));
  Serializer<ContarRefeicoesPacienteVariables> varsSerializer = (ContarRefeicoesPacienteVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ContarRefeicoesPacienteData, ContarRefeicoesPacienteVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ContarRefeicoesPacienteData, ContarRefeicoesPacienteVariables> ref() {
    ContarRefeicoesPacienteVariables vars= ContarRefeicoesPacienteVariables(pacienteId: pacienteId,);
    return _dataConnect.query("ContarRefeicoesPaciente", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ContarRefeicoesPacienteRefeicaos {
  final String id;
  ContarRefeicoesPacienteRefeicaos.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ContarRefeicoesPacienteRefeicaos otherTyped = other as ContarRefeicoesPacienteRefeicaos;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  ContarRefeicoesPacienteRefeicaos({
    required this.id,
  });
}

@immutable
class ContarRefeicoesPacienteData {
  final List<ContarRefeicoesPacienteRefeicaos> refeicaos;
  ContarRefeicoesPacienteData.fromJson(dynamic json):
  
  refeicaos = (json['refeicaos'] as List<dynamic>)
        .map((e) => ContarRefeicoesPacienteRefeicaos.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ContarRefeicoesPacienteData otherTyped = other as ContarRefeicoesPacienteData;
    return refeicaos == otherTyped.refeicaos;
    
  }
  @override
  int get hashCode => refeicaos.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['refeicaos'] = refeicaos.map((e) => e.toJson()).toList();
    return json;
  }

  ContarRefeicoesPacienteData({
    required this.refeicaos,
  });
}

@immutable
class ContarRefeicoesPacienteVariables {
  final String pacienteId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ContarRefeicoesPacienteVariables.fromJson(Map<String, dynamic> json):
  
  pacienteId = nativeFromJson<String>(json['pacienteId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ContarRefeicoesPacienteVariables otherTyped = other as ContarRefeicoesPacienteVariables;
    return pacienteId == otherTyped.pacienteId;
    
  }
  @override
  int get hashCode => pacienteId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['pacienteId'] = nativeToJson<String>(pacienteId);
    return json;
  }

  ContarRefeicoesPacienteVariables({
    required this.pacienteId,
  });
}

