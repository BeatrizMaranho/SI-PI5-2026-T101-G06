part of 'generated.dart';

class ListarPacientesVinculadosVariablesBuilder {
  String nutricionistaId;

  final FirebaseDataConnect _dataConnect;
  ListarPacientesVinculadosVariablesBuilder(this._dataConnect, {required  this.nutricionistaId,});
  Deserializer<ListarPacientesVinculadosData> dataDeserializer = (dynamic json)  => ListarPacientesVinculadosData.fromJson(jsonDecode(json));
  Serializer<ListarPacientesVinculadosVariables> varsSerializer = (ListarPacientesVinculadosVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListarPacientesVinculadosData, ListarPacientesVinculadosVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListarPacientesVinculadosData, ListarPacientesVinculadosVariables> ref() {
    ListarPacientesVinculadosVariables vars= ListarPacientesVinculadosVariables(nutricionistaId: nutricionistaId,);
    return _dataConnect.query("ListarPacientesVinculados", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListarPacientesVinculadosNutricionistaPacientes {
  final ListarPacientesVinculadosNutricionistaPacientesPaciente paciente;
  final Timestamp vinculadoEm;
  ListarPacientesVinculadosNutricionistaPacientes.fromJson(dynamic json):
  
  paciente = ListarPacientesVinculadosNutricionistaPacientesPaciente.fromJson(json['paciente']),
  vinculadoEm = Timestamp.fromJson(json['vinculadoEm']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarPacientesVinculadosNutricionistaPacientes otherTyped = other as ListarPacientesVinculadosNutricionistaPacientes;
    return paciente == otherTyped.paciente && 
    vinculadoEm == otherTyped.vinculadoEm;
    
  }
  @override
  int get hashCode => Object.hashAll([paciente.hashCode, vinculadoEm.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['paciente'] = paciente.toJson();
    json['vinculadoEm'] = vinculadoEm.toJson();
    return json;
  }

  ListarPacientesVinculadosNutricionistaPacientes({
    required this.paciente,
    required this.vinculadoEm,
  });
}

@immutable
class ListarPacientesVinculadosNutricionistaPacientesPaciente {
  final String id;
  final String nome;
  final DateTime? nascimento;
  final ListarPacientesVinculadosNutricionistaPacientesPacienteResponsavel responsavel;
  ListarPacientesVinculadosNutricionistaPacientesPaciente.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  nome = nativeFromJson<String>(json['nome']),
  nascimento = json['nascimento'] == null ? null : nativeFromJson<DateTime>(json['nascimento']),
  responsavel = ListarPacientesVinculadosNutricionistaPacientesPacienteResponsavel.fromJson(json['responsavel']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarPacientesVinculadosNutricionistaPacientesPaciente otherTyped = other as ListarPacientesVinculadosNutricionistaPacientesPaciente;
    return id == otherTyped.id && 
    nome == otherTyped.nome && 
    nascimento == otherTyped.nascimento && 
    responsavel == otherTyped.responsavel;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, nome.hashCode, nascimento.hashCode, responsavel.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['nome'] = nativeToJson<String>(nome);
    if (nascimento != null) {
      json['nascimento'] = nativeToJson<DateTime?>(nascimento);
    }
    json['responsavel'] = responsavel.toJson();
    return json;
  }

  ListarPacientesVinculadosNutricionistaPacientesPaciente({
    required this.id,
    required this.nome,
    this.nascimento,
    required this.responsavel,
  });
}

@immutable
class ListarPacientesVinculadosNutricionistaPacientesPacienteResponsavel {
  final String nome;
  final String email;
  ListarPacientesVinculadosNutricionistaPacientesPacienteResponsavel.fromJson(dynamic json):
  
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

    final ListarPacientesVinculadosNutricionistaPacientesPacienteResponsavel otherTyped = other as ListarPacientesVinculadosNutricionistaPacientesPacienteResponsavel;
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

  ListarPacientesVinculadosNutricionistaPacientesPacienteResponsavel({
    required this.nome,
    required this.email,
  });
}

@immutable
class ListarPacientesVinculadosData {
  final List<ListarPacientesVinculadosNutricionistaPacientes> nutricionistaPacientes;
  ListarPacientesVinculadosData.fromJson(dynamic json):
  
  nutricionistaPacientes = (json['nutricionistaPacientes'] as List<dynamic>)
        .map((e) => ListarPacientesVinculadosNutricionistaPacientes.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarPacientesVinculadosData otherTyped = other as ListarPacientesVinculadosData;
    return nutricionistaPacientes == otherTyped.nutricionistaPacientes;
    
  }
  @override
  int get hashCode => nutricionistaPacientes.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nutricionistaPacientes'] = nutricionistaPacientes.map((e) => e.toJson()).toList();
    return json;
  }

  ListarPacientesVinculadosData({
    required this.nutricionistaPacientes,
  });
}

@immutable
class ListarPacientesVinculadosVariables {
  final String nutricionistaId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListarPacientesVinculadosVariables.fromJson(Map<String, dynamic> json):
  
  nutricionistaId = nativeFromJson<String>(json['nutricionistaId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarPacientesVinculadosVariables otherTyped = other as ListarPacientesVinculadosVariables;
    return nutricionistaId == otherTyped.nutricionistaId;
    
  }
  @override
  int get hashCode => nutricionistaId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nutricionistaId'] = nativeToJson<String>(nutricionistaId);
    return json;
  }

  ListarPacientesVinculadosVariables({
    required this.nutricionistaId,
  });
}

