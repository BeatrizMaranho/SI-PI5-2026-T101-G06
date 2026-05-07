part of 'generated.dart';

class AtualizarDeteccaoVariablesBuilder {
  String id;
  bool aceito;

  final FirebaseDataConnect _dataConnect;
  AtualizarDeteccaoVariablesBuilder(this._dataConnect, {required  this.id,required  this.aceito,});
  Deserializer<AtualizarDeteccaoData> dataDeserializer = (dynamic json)  => AtualizarDeteccaoData.fromJson(jsonDecode(json));
  Serializer<AtualizarDeteccaoVariables> varsSerializer = (AtualizarDeteccaoVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AtualizarDeteccaoData, AtualizarDeteccaoVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AtualizarDeteccaoData, AtualizarDeteccaoVariables> ref() {
    AtualizarDeteccaoVariables vars= AtualizarDeteccaoVariables(id: id,aceito: aceito,);
    return _dataConnect.mutation("AtualizarDeteccao", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AtualizarDeteccaoDeteccaoAlimentoUpdate {
  final String id;
  AtualizarDeteccaoDeteccaoAlimentoUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AtualizarDeteccaoDeteccaoAlimentoUpdate otherTyped = other as AtualizarDeteccaoDeteccaoAlimentoUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AtualizarDeteccaoDeteccaoAlimentoUpdate({
    required this.id,
  });
}

@immutable
class AtualizarDeteccaoData {
  final AtualizarDeteccaoDeteccaoAlimentoUpdate? deteccaoAlimento_update;
  AtualizarDeteccaoData.fromJson(dynamic json):
  
  deteccaoAlimento_update = json['deteccaoAlimento_update'] == null ? null : AtualizarDeteccaoDeteccaoAlimentoUpdate.fromJson(json['deteccaoAlimento_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AtualizarDeteccaoData otherTyped = other as AtualizarDeteccaoData;
    return deteccaoAlimento_update == otherTyped.deteccaoAlimento_update;
    
  }
  @override
  int get hashCode => deteccaoAlimento_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (deteccaoAlimento_update != null) {
      json['deteccaoAlimento_update'] = deteccaoAlimento_update!.toJson();
    }
    return json;
  }

  AtualizarDeteccaoData({
    this.deteccaoAlimento_update,
  });
}

@immutable
class AtualizarDeteccaoVariables {
  final String id;
  final bool aceito;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AtualizarDeteccaoVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  aceito = nativeFromJson<bool>(json['aceito']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AtualizarDeteccaoVariables otherTyped = other as AtualizarDeteccaoVariables;
    return id == otherTyped.id && 
    aceito == otherTyped.aceito;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, aceito.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['aceito'] = nativeToJson<bool>(aceito);
    return json;
  }

  AtualizarDeteccaoVariables({
    required this.id,
    required this.aceito,
  });
}

