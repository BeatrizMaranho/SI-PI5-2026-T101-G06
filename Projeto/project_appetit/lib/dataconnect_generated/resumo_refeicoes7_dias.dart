part of 'generated.dart';

class ResumoRefeicoes7DiasVariablesBuilder {
  String pacienteId;
  Timestamp dataLimite;

  final FirebaseDataConnect _dataConnect;
  ResumoRefeicoes7DiasVariablesBuilder(this._dataConnect, {required  this.pacienteId,required  this.dataLimite,});
  Deserializer<ResumoRefeicoes7DiasData> dataDeserializer = (dynamic json)  => ResumoRefeicoes7DiasData.fromJson(jsonDecode(json));
  Serializer<ResumoRefeicoes7DiasVariables> varsSerializer = (ResumoRefeicoes7DiasVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ResumoRefeicoes7DiasData, ResumoRefeicoes7DiasVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ResumoRefeicoes7DiasData, ResumoRefeicoes7DiasVariables> ref() {
    ResumoRefeicoes7DiasVariables vars= ResumoRefeicoes7DiasVariables(pacienteId: pacienteId,dataLimite: dataLimite,);
    return _dataConnect.query("ResumoRefeicoes7Dias", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ResumoRefeicoes7DiasRefeicaos {
  final String id;
  final Timestamp dataHora;
  final String status;
  ResumoRefeicoes7DiasRefeicaos.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  dataHora = Timestamp.fromJson(json['dataHora']),
  status = nativeFromJson<String>(json['status']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ResumoRefeicoes7DiasRefeicaos otherTyped = other as ResumoRefeicoes7DiasRefeicaos;
    return id == otherTyped.id && 
    dataHora == otherTyped.dataHora && 
    status == otherTyped.status;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, dataHora.hashCode, status.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['dataHora'] = dataHora.toJson();
    json['status'] = nativeToJson<String>(status);
    return json;
  }

  ResumoRefeicoes7DiasRefeicaos({
    required this.id,
    required this.dataHora,
    required this.status,
  });
}

@immutable
class ResumoRefeicoes7DiasData {
  final List<ResumoRefeicoes7DiasRefeicaos> refeicaos;
  ResumoRefeicoes7DiasData.fromJson(dynamic json):
  
  refeicaos = (json['refeicaos'] as List<dynamic>)
        .map((e) => ResumoRefeicoes7DiasRefeicaos.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ResumoRefeicoes7DiasData otherTyped = other as ResumoRefeicoes7DiasData;
    return refeicaos == otherTyped.refeicaos;
    
  }
  @override
  int get hashCode => refeicaos.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['refeicaos'] = refeicaos.map((e) => e.toJson()).toList();
    return json;
  }

  ResumoRefeicoes7DiasData({
    required this.refeicaos,
  });
}

@immutable
class ResumoRefeicoes7DiasVariables {
  final String pacienteId;
  final Timestamp dataLimite;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ResumoRefeicoes7DiasVariables.fromJson(Map<String, dynamic> json):
  
  pacienteId = nativeFromJson<String>(json['pacienteId']),
  dataLimite = Timestamp.fromJson(json['dataLimite']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ResumoRefeicoes7DiasVariables otherTyped = other as ResumoRefeicoes7DiasVariables;
    return pacienteId == otherTyped.pacienteId && 
    dataLimite == otherTyped.dataLimite;
    
  }
  @override
  int get hashCode => Object.hashAll([pacienteId.hashCode, dataLimite.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['pacienteId'] = nativeToJson<String>(pacienteId);
    json['dataLimite'] = dataLimite.toJson();
    return json;
  }

  ResumoRefeicoes7DiasVariables({
    required this.pacienteId,
    required this.dataLimite,
  });
}

