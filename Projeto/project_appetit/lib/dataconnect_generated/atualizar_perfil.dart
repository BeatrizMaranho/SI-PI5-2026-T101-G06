part of 'generated.dart';

class AtualizarPerfilVariablesBuilder {
  String id;
  Optional<String> _nome = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _email = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  AtualizarPerfilVariablesBuilder nome(String? t) {
   _nome.value = t;
   return this;
  }
  AtualizarPerfilVariablesBuilder email(String? t) {
   _email.value = t;
   return this;
  }

  AtualizarPerfilVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<AtualizarPerfilData> dataDeserializer = (dynamic json)  => AtualizarPerfilData.fromJson(jsonDecode(json));
  Serializer<AtualizarPerfilVariables> varsSerializer = (AtualizarPerfilVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AtualizarPerfilData, AtualizarPerfilVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AtualizarPerfilData, AtualizarPerfilVariables> ref() {
    AtualizarPerfilVariables vars= AtualizarPerfilVariables(id: id,nome: _nome,email: _email,);
    return _dataConnect.mutation("AtualizarPerfil", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AtualizarPerfilUsuarioUpdate {
  final String id;
  AtualizarPerfilUsuarioUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AtualizarPerfilUsuarioUpdate otherTyped = other as AtualizarPerfilUsuarioUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AtualizarPerfilUsuarioUpdate({
    required this.id,
  });
}

@immutable
class AtualizarPerfilData {
  final AtualizarPerfilUsuarioUpdate? usuario_update;
  AtualizarPerfilData.fromJson(dynamic json):
  
  usuario_update = json['usuario_update'] == null ? null : AtualizarPerfilUsuarioUpdate.fromJson(json['usuario_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AtualizarPerfilData otherTyped = other as AtualizarPerfilData;
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

  AtualizarPerfilData({
    this.usuario_update,
  });
}

@immutable
class AtualizarPerfilVariables {
  final String id;
  late final Optional<String>nome;
  late final Optional<String>email;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AtualizarPerfilVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']) {
  
  
  
    nome = Optional.optional(nativeFromJson, nativeToJson);
    nome.value = json['nome'] == null ? null : nativeFromJson<String>(json['nome']);
  
  
    email = Optional.optional(nativeFromJson, nativeToJson);
    email.value = json['email'] == null ? null : nativeFromJson<String>(json['email']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AtualizarPerfilVariables otherTyped = other as AtualizarPerfilVariables;
    return id == otherTyped.id && 
    nome == otherTyped.nome && 
    email == otherTyped.email;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, nome.hashCode, email.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if(nome.state == OptionalState.set) {
      json['nome'] = nome.toJson();
    }
    if(email.state == OptionalState.set) {
      json['email'] = email.toJson();
    }
    return json;
  }

  AtualizarPerfilVariables({
    required this.id,
    required this.nome,
    required this.email,
  });
}

