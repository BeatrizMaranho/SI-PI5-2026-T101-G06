part of 'generated.dart';

class MarcarRefeicaoAnalisadaVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  MarcarRefeicaoAnalisadaVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<MarcarRefeicaoAnalisadaData> dataDeserializer = (dynamic json)  => MarcarRefeicaoAnalisadaData.fromJson(jsonDecode(json));
  Serializer<MarcarRefeicaoAnalisadaVariables> varsSerializer = (MarcarRefeicaoAnalisadaVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<MarcarRefeicaoAnalisadaData, MarcarRefeicaoAnalisadaVariables>> execute() {
    return ref().execute();
  }

  MutationRef<MarcarRefeicaoAnalisadaData, MarcarRefeicaoAnalisadaVariables> ref() {
    MarcarRefeicaoAnalisadaVariables vars= MarcarRefeicaoAnalisadaVariables(id: id,);
    return _dataConnect.mutation("MarcarRefeicaoAnalisada", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class MarcarRefeicaoAnalisadaRefeicaoUpdate {
  final String id;
  MarcarRefeicaoAnalisadaRefeicaoUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MarcarRefeicaoAnalisadaRefeicaoUpdate otherTyped = other as MarcarRefeicaoAnalisadaRefeicaoUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  MarcarRefeicaoAnalisadaRefeicaoUpdate({
    required this.id,
  });
}

@immutable
class MarcarRefeicaoAnalisadaData {
  final MarcarRefeicaoAnalisadaRefeicaoUpdate? refeicao_update;
  MarcarRefeicaoAnalisadaData.fromJson(dynamic json):
  
  refeicao_update = json['refeicao_update'] == null ? null : MarcarRefeicaoAnalisadaRefeicaoUpdate.fromJson(json['refeicao_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MarcarRefeicaoAnalisadaData otherTyped = other as MarcarRefeicaoAnalisadaData;
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

  MarcarRefeicaoAnalisadaData({
    this.refeicao_update,
  });
}

@immutable
class MarcarRefeicaoAnalisadaVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  MarcarRefeicaoAnalisadaVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MarcarRefeicaoAnalisadaVariables otherTyped = other as MarcarRefeicaoAnalisadaVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  MarcarRefeicaoAnalisadaVariables({
    required this.id,
  });
}

