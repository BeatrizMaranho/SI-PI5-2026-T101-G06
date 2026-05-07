part of 'generated.dart';

class RejeitarRefeicaoVariablesBuilder {
  String id;
  Optional<String> _motivo = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  RejeitarRefeicaoVariablesBuilder motivo(String? t) {
   _motivo.value = t;
   return this;
  }

  RejeitarRefeicaoVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<RejeitarRefeicaoData> dataDeserializer = (dynamic json)  => RejeitarRefeicaoData.fromJson(jsonDecode(json));
  Serializer<RejeitarRefeicaoVariables> varsSerializer = (RejeitarRefeicaoVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<RejeitarRefeicaoData, RejeitarRefeicaoVariables>> execute() {
    return ref().execute();
  }

  MutationRef<RejeitarRefeicaoData, RejeitarRefeicaoVariables> ref() {
    RejeitarRefeicaoVariables vars= RejeitarRefeicaoVariables(id: id,motivo: _motivo,);
    return _dataConnect.mutation("RejeitarRefeicao", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class RejeitarRefeicaoRefeicaoUpdate {
  final String id;
  RejeitarRefeicaoRefeicaoUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RejeitarRefeicaoRefeicaoUpdate otherTyped = other as RejeitarRefeicaoRefeicaoUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  RejeitarRefeicaoRefeicaoUpdate({
    required this.id,
  });
}

@immutable
class RejeitarRefeicaoData {
  final RejeitarRefeicaoRefeicaoUpdate? refeicao_update;
  RejeitarRefeicaoData.fromJson(dynamic json):
  
  refeicao_update = json['refeicao_update'] == null ? null : RejeitarRefeicaoRefeicaoUpdate.fromJson(json['refeicao_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RejeitarRefeicaoData otherTyped = other as RejeitarRefeicaoData;
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

  RejeitarRefeicaoData({
    this.refeicao_update,
  });
}

@immutable
class RejeitarRefeicaoVariables {
  final String id;
  late final Optional<String>motivo;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  RejeitarRefeicaoVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']) {
  
  
  
    motivo = Optional.optional(nativeFromJson, nativeToJson);
    motivo.value = json['motivo'] == null ? null : nativeFromJson<String>(json['motivo']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RejeitarRefeicaoVariables otherTyped = other as RejeitarRefeicaoVariables;
    return id == otherTyped.id && 
    motivo == otherTyped.motivo;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, motivo.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if(motivo.state == OptionalState.set) {
      json['motivo'] = motivo.toJson();
    }
    return json;
  }

  RejeitarRefeicaoVariables({
    required this.id,
    required this.motivo,
  });
}

