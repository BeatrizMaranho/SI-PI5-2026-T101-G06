part of 'generated.dart';

class ObterUsuarioAtualVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  ObterUsuarioAtualVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<ObterUsuarioAtualData> dataDeserializer = (dynamic json)  => ObterUsuarioAtualData.fromJson(jsonDecode(json));
  Serializer<ObterUsuarioAtualVariables> varsSerializer = (ObterUsuarioAtualVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ObterUsuarioAtualData, ObterUsuarioAtualVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ObterUsuarioAtualData, ObterUsuarioAtualVariables> ref() {
    ObterUsuarioAtualVariables vars= ObterUsuarioAtualVariables(id: id,);
    return _dataConnect.query("ObterUsuarioAtual", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ObterUsuarioAtualUsuario {
  final String id;
  final String nome;
  final String email;
  final String tipo;
  final Timestamp criadoEm;
  ObterUsuarioAtualUsuario.fromJson(dynamic json):
  
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

    final ObterUsuarioAtualUsuario otherTyped = other as ObterUsuarioAtualUsuario;
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

  ObterUsuarioAtualUsuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.tipo,
    required this.criadoEm,
  });
}

@immutable
class ObterUsuarioAtualData {
  final ObterUsuarioAtualUsuario? usuario;
  ObterUsuarioAtualData.fromJson(dynamic json):
  
  usuario = json['usuario'] == null ? null : ObterUsuarioAtualUsuario.fromJson(json['usuario']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterUsuarioAtualData otherTyped = other as ObterUsuarioAtualData;
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

  ObterUsuarioAtualData({
    this.usuario,
  });
}

@immutable
class ObterUsuarioAtualVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ObterUsuarioAtualVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterUsuarioAtualVariables otherTyped = other as ObterUsuarioAtualVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  ObterUsuarioAtualVariables({
    required this.id,
  });
}

