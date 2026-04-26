part of 'generated.dart';

class CriarUsuarioVariablesBuilder {
  String nome;
  String email;
  String senhaHash;
  String tipo;

  final FirebaseDataConnect _dataConnect;
  CriarUsuarioVariablesBuilder(this._dataConnect, {required  this.nome,required  this.email,required  this.senhaHash,required  this.tipo,});
  Deserializer<CriarUsuarioData> dataDeserializer = (dynamic json)  => CriarUsuarioData.fromJson(jsonDecode(json));
  Serializer<CriarUsuarioVariables> varsSerializer = (CriarUsuarioVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CriarUsuarioData, CriarUsuarioVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CriarUsuarioData, CriarUsuarioVariables> ref() {
    CriarUsuarioVariables vars= CriarUsuarioVariables(nome: nome,email: email,senhaHash: senhaHash,tipo: tipo,);
    return _dataConnect.mutation("CriarUsuario", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CriarUsuarioUsuarioInsert {
  final String id;
  CriarUsuarioUsuarioInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CriarUsuarioUsuarioInsert otherTyped = other as CriarUsuarioUsuarioInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CriarUsuarioUsuarioInsert({
    required this.id,
  });
}

@immutable
class CriarUsuarioData {
  final CriarUsuarioUsuarioInsert usuario_insert;
  CriarUsuarioData.fromJson(dynamic json):
  
  usuario_insert = CriarUsuarioUsuarioInsert.fromJson(json['usuario_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CriarUsuarioData otherTyped = other as CriarUsuarioData;
    return usuario_insert == otherTyped.usuario_insert;
    
  }
  @override
  int get hashCode => usuario_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['usuario_insert'] = usuario_insert.toJson();
    return json;
  }

  CriarUsuarioData({
    required this.usuario_insert,
  });
}

@immutable
class CriarUsuarioVariables {
  final String nome;
  final String email;
  final String senhaHash;
  final String tipo;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CriarUsuarioVariables.fromJson(Map<String, dynamic> json):
  
  nome = nativeFromJson<String>(json['nome']),
  email = nativeFromJson<String>(json['email']),
  senhaHash = nativeFromJson<String>(json['senhaHash']),
  tipo = nativeFromJson<String>(json['tipo']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CriarUsuarioVariables otherTyped = other as CriarUsuarioVariables;
    return nome == otherTyped.nome && 
    email == otherTyped.email && 
    senhaHash == otherTyped.senhaHash && 
    tipo == otherTyped.tipo;
    
  }
  @override
  int get hashCode => Object.hashAll([nome.hashCode, email.hashCode, senhaHash.hashCode, tipo.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nome'] = nativeToJson<String>(nome);
    json['email'] = nativeToJson<String>(email);
    json['senhaHash'] = nativeToJson<String>(senhaHash);
    json['tipo'] = nativeToJson<String>(tipo);
    return json;
  }

  CriarUsuarioVariables({
    required this.nome,
    required this.email,
    required this.senhaHash,
    required this.tipo,
  });
}

