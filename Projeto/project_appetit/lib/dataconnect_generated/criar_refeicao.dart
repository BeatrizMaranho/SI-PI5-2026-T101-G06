part of 'generated.dart';

class CriarRefeicaoVariablesBuilder {
  String pacienteId;
  String urlFotoAntes;
  Optional<String> _status = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CriarRefeicaoVariablesBuilder status(String? t) {
   _status.value = t;
   return this;
  }

  CriarRefeicaoVariablesBuilder(this._dataConnect, {required  this.pacienteId,required  this.urlFotoAntes,});
  Deserializer<CriarRefeicaoData> dataDeserializer = (dynamic json)  => CriarRefeicaoData.fromJson(jsonDecode(json));
  Serializer<CriarRefeicaoVariables> varsSerializer = (CriarRefeicaoVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CriarRefeicaoData, CriarRefeicaoVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CriarRefeicaoData, CriarRefeicaoVariables> ref() {
    CriarRefeicaoVariables vars= CriarRefeicaoVariables(pacienteId: pacienteId,urlFotoAntes: urlFotoAntes,status: _status,);
    return _dataConnect.mutation("CriarRefeicao", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CriarRefeicaoRefeicaoInsert {
  final String id;
  CriarRefeicaoRefeicaoInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CriarRefeicaoRefeicaoInsert otherTyped = other as CriarRefeicaoRefeicaoInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CriarRefeicaoRefeicaoInsert({
    required this.id,
  });
}

@immutable
class CriarRefeicaoData {
  final CriarRefeicaoRefeicaoInsert refeicao_insert;
  CriarRefeicaoData.fromJson(dynamic json):
  
  refeicao_insert = CriarRefeicaoRefeicaoInsert.fromJson(json['refeicao_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CriarRefeicaoData otherTyped = other as CriarRefeicaoData;
    return refeicao_insert == otherTyped.refeicao_insert;
    
  }
  @override
  int get hashCode => refeicao_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['refeicao_insert'] = refeicao_insert.toJson();
    return json;
  }

  CriarRefeicaoData({
    required this.refeicao_insert,
  });
}

@immutable
class CriarRefeicaoVariables {
  final String pacienteId;
  final String urlFotoAntes;
  late final Optional<String>status;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CriarRefeicaoVariables.fromJson(Map<String, dynamic> json):
  
  pacienteId = nativeFromJson<String>(json['pacienteId']),
  urlFotoAntes = nativeFromJson<String>(json['urlFotoAntes']) {
  
  
  
  
    status = Optional.optional(nativeFromJson, nativeToJson);
    status.value = json['status'] == null ? null : nativeFromJson<String>(json['status']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CriarRefeicaoVariables otherTyped = other as CriarRefeicaoVariables;
    return pacienteId == otherTyped.pacienteId && 
    urlFotoAntes == otherTyped.urlFotoAntes && 
    status == otherTyped.status;
    
  }
  @override
  int get hashCode => Object.hashAll([pacienteId.hashCode, urlFotoAntes.hashCode, status.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['pacienteId'] = nativeToJson<String>(pacienteId);
    json['urlFotoAntes'] = nativeToJson<String>(urlFotoAntes);
    if(status.state == OptionalState.set) {
      json['status'] = status.toJson();
    }
    return json;
  }

  CriarRefeicaoVariables({
    required this.pacienteId,
    required this.urlFotoAntes,
    required this.status,
  });
}

