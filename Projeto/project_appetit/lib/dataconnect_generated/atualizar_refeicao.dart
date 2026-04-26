part of 'generated.dart';

class AtualizarRefeicaoVariablesBuilder {
  String id;
  Optional<String> _urlFotoDepois = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _status = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  AtualizarRefeicaoVariablesBuilder urlFotoDepois(String? t) {
   _urlFotoDepois.value = t;
   return this;
  }
  AtualizarRefeicaoVariablesBuilder status(String? t) {
   _status.value = t;
   return this;
  }

  AtualizarRefeicaoVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<AtualizarRefeicaoData> dataDeserializer = (dynamic json)  => AtualizarRefeicaoData.fromJson(jsonDecode(json));
  Serializer<AtualizarRefeicaoVariables> varsSerializer = (AtualizarRefeicaoVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AtualizarRefeicaoData, AtualizarRefeicaoVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AtualizarRefeicaoData, AtualizarRefeicaoVariables> ref() {
    AtualizarRefeicaoVariables vars= AtualizarRefeicaoVariables(id: id,urlFotoDepois: _urlFotoDepois,status: _status,);
    return _dataConnect.mutation("AtualizarRefeicao", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AtualizarRefeicaoRefeicaoUpdate {
  final String id;
  AtualizarRefeicaoRefeicaoUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AtualizarRefeicaoRefeicaoUpdate otherTyped = other as AtualizarRefeicaoRefeicaoUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AtualizarRefeicaoRefeicaoUpdate({
    required this.id,
  });
}

@immutable
class AtualizarRefeicaoData {
  final AtualizarRefeicaoRefeicaoUpdate? refeicao_update;
  AtualizarRefeicaoData.fromJson(dynamic json):
  
  refeicao_update = json['refeicao_update'] == null ? null : AtualizarRefeicaoRefeicaoUpdate.fromJson(json['refeicao_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AtualizarRefeicaoData otherTyped = other as AtualizarRefeicaoData;
    return refeicao_update == otherTyped.refeicao_update;
    
  }
  @override
  int get hashCode => refeicao_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (refeicao_update != null) {
      json['refeicao_update'] = refeicao_update!.toJson();
    }
    return json;
  }

  AtualizarRefeicaoData({
    this.refeicao_update,
  });
}

@immutable
class AtualizarRefeicaoVariables {
  final String id;
  late final Optional<String>urlFotoDepois;
  late final Optional<String>status;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AtualizarRefeicaoVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']) {
  
  
  
    urlFotoDepois = Optional.optional(nativeFromJson, nativeToJson);
    urlFotoDepois.value = json['urlFotoDepois'] == null ? null : nativeFromJson<String>(json['urlFotoDepois']);
  
  
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

    final AtualizarRefeicaoVariables otherTyped = other as AtualizarRefeicaoVariables;
    return id == otherTyped.id && 
    urlFotoDepois == otherTyped.urlFotoDepois && 
    status == otherTyped.status;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, urlFotoDepois.hashCode, status.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if(urlFotoDepois.state == OptionalState.set) {
      json['urlFotoDepois'] = urlFotoDepois.toJson();
    }
    if(status.state == OptionalState.set) {
      json['status'] = status.toJson();
    }
    return json;
  }

  AtualizarRefeicaoVariables({
    required this.id,
    required this.urlFotoDepois,
    required this.status,
  });
}

