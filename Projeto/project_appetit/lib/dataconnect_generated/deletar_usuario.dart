part of 'generated.dart';

class DeletarUsuarioVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeletarUsuarioVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeletarUsuarioData> dataDeserializer = (dynamic json)  => DeletarUsuarioData.fromJson(jsonDecode(json));
  Serializer<DeletarUsuarioVariables> varsSerializer = (DeletarUsuarioVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeletarUsuarioData, DeletarUsuarioVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeletarUsuarioData, DeletarUsuarioVariables> ref() {
    DeletarUsuarioVariables vars= DeletarUsuarioVariables(id: id,);
    return _dataConnect.mutation("DeletarUsuario", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeletarUsuarioUsuarioDelete {
  final String id;
  DeletarUsuarioUsuarioDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletarUsuarioUsuarioDelete otherTyped = other as DeletarUsuarioUsuarioDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeletarUsuarioUsuarioDelete({
    required this.id,
  });
}

@immutable
class DeletarUsuarioData {
  final DeletarUsuarioUsuarioDelete? usuario_delete;
  DeletarUsuarioData.fromJson(dynamic json):
  
  usuario_delete = json['usuario_delete'] == null ? null : DeletarUsuarioUsuarioDelete.fromJson(json['usuario_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletarUsuarioData otherTyped = other as DeletarUsuarioData;
    return usuario_delete == otherTyped.usuario_delete;
    
  }
  @override
  int get hashCode => usuario_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (usuario_delete != null) {
      json['usuario_delete'] = usuario_delete!.toJson();
    }
    return json;
  }

  DeletarUsuarioData({
    this.usuario_delete,
  });
}

@immutable
class DeletarUsuarioVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeletarUsuarioVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletarUsuarioVariables otherTyped = other as DeletarUsuarioVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeletarUsuarioVariables({
    required this.id,
  });
}

