part of 'generated.dart';

class CriarRefeicaoVariablesBuilder {
  String pacienteId;
  String status;
  String urlFotoAntes;
  String urlFotoDepois;
  Optional<String> _analise = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CriarRefeicaoVariablesBuilder analise(String? t) {
   _analise.value = t;
   return this;
  }

  CriarRefeicaoVariablesBuilder(this._dataConnect, {required  this.pacienteId,required  this.status,required  this.urlFotoAntes,required  this.urlFotoDepois,});
  Deserializer<CriarRefeicaoData> dataDeserializer = (dynamic json)  => CriarRefeicaoData.fromJson(jsonDecode(json));
  Serializer<CriarRefeicaoVariables> varsSerializer = (CriarRefeicaoVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CriarRefeicaoData, CriarRefeicaoVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CriarRefeicaoData, CriarRefeicaoVariables> ref() {
    CriarRefeicaoVariables vars= CriarRefeicaoVariables(pacienteId: pacienteId,status: status,urlFotoAntes: urlFotoAntes,urlFotoDepois: urlFotoDepois,analise: _analise,);
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
  final String status;
  final String urlFotoAntes;
  final String urlFotoDepois;
  late final Optional<String>analise;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CriarRefeicaoVariables.fromJson(Map<String, dynamic> json):
  
  pacienteId = nativeFromJson<String>(json['pacienteId']),
  status = nativeFromJson<String>(json['status']),
  urlFotoAntes = nativeFromJson<String>(json['urlFotoAntes']),
  urlFotoDepois = nativeFromJson<String>(json['urlFotoDepois']) {
  
  
  
  
  
  
    analise = Optional.optional(nativeFromJson, nativeToJson);
    analise.value = json['analise'] == null ? null : nativeFromJson<String>(json['analise']);
  
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
    status == otherTyped.status && 
    urlFotoAntes == otherTyped.urlFotoAntes && 
    urlFotoDepois == otherTyped.urlFotoDepois && 
    analise == otherTyped.analise;
    
  }
  @override
  int get hashCode => Object.hashAll([pacienteId.hashCode, status.hashCode, urlFotoAntes.hashCode, urlFotoDepois.hashCode, analise.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['pacienteId'] = nativeToJson<String>(pacienteId);
    json['status'] = nativeToJson<String>(status);
    json['urlFotoAntes'] = nativeToJson<String>(urlFotoAntes);
    json['urlFotoDepois'] = nativeToJson<String>(urlFotoDepois);
    if(analise.state == OptionalState.set) {
      json['analise'] = analise.toJson();
    }
    return json;
  }

  CriarRefeicaoVariables({
    required this.pacienteId,
    required this.status,
    required this.urlFotoAntes,
    required this.urlFotoDepois,
    required this.analise,
  });
}

