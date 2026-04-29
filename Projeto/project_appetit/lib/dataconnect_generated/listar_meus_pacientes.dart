part of 'generated.dart';

class ListarMeusPacientesVariablesBuilder {
  String responsavelId;

  final FirebaseDataConnect _dataConnect;
  ListarMeusPacientesVariablesBuilder(this._dataConnect, {required  this.responsavelId,});
  Deserializer<ListarMeusPacientesData> dataDeserializer = (dynamic json)  => ListarMeusPacientesData.fromJson(jsonDecode(json));
  Serializer<ListarMeusPacientesVariables> varsSerializer = (ListarMeusPacientesVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListarMeusPacientesData, ListarMeusPacientesVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListarMeusPacientesData, ListarMeusPacientesVariables> ref() {
    ListarMeusPacientesVariables vars= ListarMeusPacientesVariables(responsavelId: responsavelId,);
    return _dataConnect.query("ListarMeusPacientes", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListarMeusPacientesPacientes {
  final String id;
  final String nome;
  final DateTime? nascimento;
  final double? peso;
  final String? alergias;
  final Timestamp criadoEm;
  final ListarMeusPacientesPacientesResponsavel responsavel;
  ListarMeusPacientesPacientes.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  nome = nativeFromJson<String>(json['nome']),
  nascimento = json['nascimento'] == null ? null : nativeFromJson<DateTime>(json['nascimento']),
  peso = json['peso'] == null ? null : nativeFromJson<double>(json['peso']),
  alergias = json['alergias'] == null ? null : nativeFromJson<String>(json['alergias']),
  criadoEm = Timestamp.fromJson(json['criadoEm']),
  responsavel = ListarMeusPacientesPacientesResponsavel.fromJson(json['responsavel']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarMeusPacientesPacientes otherTyped = other as ListarMeusPacientesPacientes;
    return id == otherTyped.id && 
    nome == otherTyped.nome && 
    nascimento == otherTyped.nascimento && 
    peso == otherTyped.peso && 
    alergias == otherTyped.alergias && 
    criadoEm == otherTyped.criadoEm && 
    responsavel == otherTyped.responsavel;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, nome.hashCode, nascimento.hashCode, peso.hashCode, alergias.hashCode, criadoEm.hashCode, responsavel.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['nome'] = nativeToJson<String>(nome);
    if (nascimento != null) {
      json['nascimento'] = nativeToJson<DateTime?>(nascimento);
    }
    if (peso != null) {
      json['peso'] = nativeToJson<double?>(peso);
    }
    if (alergias != null) {
      json['alergias'] = nativeToJson<String?>(alergias);
    }
    json['criadoEm'] = criadoEm.toJson();
    json['responsavel'] = responsavel.toJson();
    return json;
  }

  ListarMeusPacientesPacientes({
    required this.id,
    required this.nome,
    this.nascimento,
    this.peso,
    this.alergias,
    required this.criadoEm,
    required this.responsavel,
  });
}

@immutable
class ListarMeusPacientesPacientesResponsavel {
  final String nome;
  final String email;
  ListarMeusPacientesPacientesResponsavel.fromJson(dynamic json):
  
  nome = nativeFromJson<String>(json['nome']),
  email = nativeFromJson<String>(json['email']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarMeusPacientesPacientesResponsavel otherTyped = other as ListarMeusPacientesPacientesResponsavel;
    return nome == otherTyped.nome && 
    email == otherTyped.email;
    
  }
  @override
  int get hashCode => Object.hashAll([nome.hashCode, email.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nome'] = nativeToJson<String>(nome);
    json['email'] = nativeToJson<String>(email);
    return json;
  }

  ListarMeusPacientesPacientesResponsavel({
    required this.nome,
    required this.email,
  });
}

@immutable
class ListarMeusPacientesData {
  final List<ListarMeusPacientesPacientes> pacientes;
  ListarMeusPacientesData.fromJson(dynamic json):
  
  pacientes = (json['pacientes'] as List<dynamic>)
        .map((e) => ListarMeusPacientesPacientes.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarMeusPacientesData otherTyped = other as ListarMeusPacientesData;
    return pacientes == otherTyped.pacientes;
    
  }
  @override
  int get hashCode => pacientes.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['pacientes'] = pacientes.map((e) => e.toJson()).toList();
    return json;
  }

  ListarMeusPacientesData({
    required this.pacientes,
  });
}

@immutable
class ListarMeusPacientesVariables {
  final String responsavelId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListarMeusPacientesVariables.fromJson(Map<String, dynamic> json):
  
  responsavelId = nativeFromJson<String>(json['responsavelId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarMeusPacientesVariables otherTyped = other as ListarMeusPacientesVariables;
    return responsavelId == otherTyped.responsavelId;
    
  }
  @override
  int get hashCode => responsavelId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['responsavelId'] = nativeToJson<String>(responsavelId);
    return json;
  }

  ListarMeusPacientesVariables({
    required this.responsavelId,
  });
}

