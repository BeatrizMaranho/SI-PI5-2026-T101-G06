part of 'generated.dart';

class ObterUsuarioPorIdVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  ObterUsuarioPorIdVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<ObterUsuarioPorIdData> dataDeserializer = (dynamic json)  => ObterUsuarioPorIdData.fromJson(jsonDecode(json));
  Serializer<ObterUsuarioPorIdVariables> varsSerializer = (ObterUsuarioPorIdVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ObterUsuarioPorIdData, ObterUsuarioPorIdVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ObterUsuarioPorIdData, ObterUsuarioPorIdVariables> ref() {
    ObterUsuarioPorIdVariables vars= ObterUsuarioPorIdVariables(id: id,);
    return _dataConnect.query("ObterUsuarioPorId", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ObterUsuarioPorIdUsuario {
  final String id;
  final String nome;
  final String email;
  final String tipo;
  final Timestamp criadoEm;
  ObterUsuarioPorIdUsuario.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  nome = nativeFromJson<String>(json['nome']),
  email = nativeFromJson<String>(json['email']),
  tipo = nativeFromJson<String>(json['tipo']),
  criadoEm = Timestamp.fromJson(json['criadoEm']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterUsuarioPorIdUsuario otherTyped = other as ObterUsuarioPorIdUsuario;
    return id == otherTyped.id && 
    nome == otherTyped.nome && 
    email == otherTyped.email && 
    tipo == otherTyped.tipo && 
    criadoEm == otherTyped.criadoEm;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, nome.hashCode, email.hashCode, tipo.hashCode, criadoEm.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['nome'] = nativeToJson<String>(nome);
    json['email'] = nativeToJson<String>(email);
    json['tipo'] = nativeToJson<String>(tipo);
    json['criadoEm'] = criadoEm.toJson();
    return json;
  }

  ObterUsuarioPorIdUsuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.tipo,
    required this.criadoEm,
  });
}

@immutable
class ObterUsuarioPorIdData {
  final ObterUsuarioPorIdUsuario? usuario;
  ObterUsuarioPorIdData.fromJson(dynamic json):
  
  usuario = json['usuario'] == null ? null : ObterUsuarioPorIdUsuario.fromJson(json['usuario']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterUsuarioPorIdData otherTyped = other as ObterUsuarioPorIdData;
    return usuario == otherTyped.usuario;
    
  }
  @override
  int get hashCode => usuario.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (usuario != null) {
      json['usuario'] = usuario!.toJson();
    }
    return json;
  }

  ObterUsuarioPorIdData({
    this.usuario,
  });
}

@immutable
class ObterUsuarioPorIdVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ObterUsuarioPorIdVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterUsuarioPorIdVariables otherTyped = other as ObterUsuarioPorIdVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  ObterUsuarioPorIdVariables({
    required this.id,
  });
}

