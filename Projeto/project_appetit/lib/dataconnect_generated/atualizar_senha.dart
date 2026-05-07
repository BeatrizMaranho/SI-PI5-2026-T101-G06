part of 'generated.dart';

class AtualizarSenhaVariablesBuilder {
  String id;
  String senhaHashNova;

  final FirebaseDataConnect _dataConnect;
  AtualizarSenhaVariablesBuilder(this._dataConnect, {required  this.id,required  this.senhaHashNova,});
  Deserializer<AtualizarSenhaData> dataDeserializer = (dynamic json)  => AtualizarSenhaData.fromJson(jsonDecode(json));
  Serializer<AtualizarSenhaVariables> varsSerializer = (AtualizarSenhaVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AtualizarSenhaData, AtualizarSenhaVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AtualizarSenhaData, AtualizarSenhaVariables> ref() {
    AtualizarSenhaVariables vars= AtualizarSenhaVariables(id: id,senhaHashNova: senhaHashNova,);
    return _dataConnect.mutation("AtualizarSenha", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AtualizarSenhaUsuarioUpdate {
  final String id;
  AtualizarSenhaUsuarioUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AtualizarSenhaUsuarioUpdate otherTyped = other as AtualizarSenhaUsuarioUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AtualizarSenhaUsuarioUpdate({
    required this.id,
  });
}

@immutable
class AtualizarSenhaData {
  final AtualizarSenhaUsuarioUpdate? usuario_update;
  AtualizarSenhaData.fromJson(dynamic json):
  
  usuario_update = json['usuario_update'] == null ? null : AtualizarSenhaUsuarioUpdate.fromJson(json['usuario_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AtualizarSenhaData otherTyped = other as AtualizarSenhaData;
    return usuario_update == otherTyped.usuario_update;
    
  }
  @override
  int get hashCode => usuario_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (usuario_update != null) {
      json['usuario_update'] = usuario_update!.toJson();
    }
    return json;
  }

  AtualizarSenhaData({
    this.usuario_update,
  });
}

@immutable
class AtualizarSenhaVariables {
  final String id;
  final String senhaHashNova;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AtualizarSenhaVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  senhaHashNova = nativeFromJson<String>(json['senhaHashNova']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AtualizarSenhaVariables otherTyped = other as AtualizarSenhaVariables;
    return id == otherTyped.id && 
    senhaHashNova == otherTyped.senhaHashNova;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, senhaHashNova.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['senhaHashNova'] = nativeToJson<String>(senhaHashNova);
    return json;
  }

  AtualizarSenhaVariables({
    required this.id,
    required this.senhaHashNova,
  });
}

