part of 'generated.dart';

class BuscarUsuarioPorEmailVariablesBuilder {
  String email;

  final FirebaseDataConnect _dataConnect;
  BuscarUsuarioPorEmailVariablesBuilder(this._dataConnect, {required  this.email,});
  Deserializer<BuscarUsuarioPorEmailData> dataDeserializer = (dynamic json)  => BuscarUsuarioPorEmailData.fromJson(jsonDecode(json));
  Serializer<BuscarUsuarioPorEmailVariables> varsSerializer = (BuscarUsuarioPorEmailVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<BuscarUsuarioPorEmailData, BuscarUsuarioPorEmailVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<BuscarUsuarioPorEmailData, BuscarUsuarioPorEmailVariables> ref() {
    BuscarUsuarioPorEmailVariables vars= BuscarUsuarioPorEmailVariables(email: email,);
    return _dataConnect.query("BuscarUsuarioPorEmail", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class BuscarUsuarioPorEmailUsuarios {
  final String id;
  final String nome;
  final String email;
  final String tipo;
  final String senhaHash;
  final Timestamp criadoEm;
  BuscarUsuarioPorEmailUsuarios.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  nome = nativeFromJson<String>(json['nome']),
  email = nativeFromJson<String>(json['email']),
  tipo = nativeFromJson<String>(json['tipo']),
  senhaHash = nativeFromJson<String>(json['senhaHash']),
  criadoEm = Timestamp.fromJson(json['criadoEm']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final BuscarUsuarioPorEmailUsuarios otherTyped = other as BuscarUsuarioPorEmailUsuarios;
    return id == otherTyped.id && 
    nome == otherTyped.nome && 
    email == otherTyped.email && 
    tipo == otherTyped.tipo && 
    senhaHash == otherTyped.senhaHash && 
    criadoEm == otherTyped.criadoEm;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, nome.hashCode, email.hashCode, tipo.hashCode, senhaHash.hashCode, criadoEm.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['nome'] = nativeToJson<String>(nome);
    json['email'] = nativeToJson<String>(email);
    json['tipo'] = nativeToJson<String>(tipo);
    json['senhaHash'] = nativeToJson<String>(senhaHash);
    json['criadoEm'] = criadoEm.toJson();
    return json;
  }

  BuscarUsuarioPorEmailUsuarios({
    required this.id,
    required this.nome,
    required this.email,
    required this.tipo,
    required this.senhaHash,
    required this.criadoEm,
  });
}

@immutable
class BuscarUsuarioPorEmailData {
  final List<BuscarUsuarioPorEmailUsuarios> usuarios;
  BuscarUsuarioPorEmailData.fromJson(dynamic json):
  
  usuarios = (json['usuarios'] as List<dynamic>)
        .map((e) => BuscarUsuarioPorEmailUsuarios.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final BuscarUsuarioPorEmailData otherTyped = other as BuscarUsuarioPorEmailData;
    return usuarios == otherTyped.usuarios;
    
  }
  @override
  int get hashCode => usuarios.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['usuarios'] = usuarios.map((e) => e.toJson()).toList();
    return json;
  }

  BuscarUsuarioPorEmailData({
    required this.usuarios,
  });
}

@immutable
class BuscarUsuarioPorEmailVariables {
  final String email;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  BuscarUsuarioPorEmailVariables.fromJson(Map<String, dynamic> json):
  
  email = nativeFromJson<String>(json['email']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final BuscarUsuarioPorEmailVariables otherTyped = other as BuscarUsuarioPorEmailVariables;
    return email == otherTyped.email;
    
  }
  @override
  int get hashCode => email.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['email'] = nativeToJson<String>(email);
    return json;
  }

  BuscarUsuarioPorEmailVariables({
    required this.email,
  });
}

