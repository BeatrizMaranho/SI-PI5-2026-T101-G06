part of 'generated.dart';

class CriarPacienteVariablesBuilder {
  String nome;
  String responsavelId;
  Optional<DateTime> _nascimento = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CriarPacienteVariablesBuilder nascimento(DateTime? t) {
   _nascimento.value = t;
   return this;
  }

  CriarPacienteVariablesBuilder(this._dataConnect, {required  this.nome,required  this.responsavelId,});
  Deserializer<CriarPacienteData> dataDeserializer = (dynamic json)  => CriarPacienteData.fromJson(jsonDecode(json));
  Serializer<CriarPacienteVariables> varsSerializer = (CriarPacienteVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CriarPacienteData, CriarPacienteVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CriarPacienteData, CriarPacienteVariables> ref() {
    CriarPacienteVariables vars= CriarPacienteVariables(nome: nome,responsavelId: responsavelId,nascimento: _nascimento,);
    return _dataConnect.mutation("CriarPaciente", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CriarPacientePacienteInsert {
  final String id;
  CriarPacientePacienteInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CriarPacientePacienteInsert otherTyped = other as CriarPacientePacienteInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CriarPacientePacienteInsert({
    required this.id,
  });
}

@immutable
class CriarPacienteData {
  final CriarPacientePacienteInsert paciente_insert;
  CriarPacienteData.fromJson(dynamic json):
  
  paciente_insert = CriarPacientePacienteInsert.fromJson(json['paciente_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CriarPacienteData otherTyped = other as CriarPacienteData;
    return paciente_insert == otherTyped.paciente_insert;
    
  }
  @override
  int get hashCode => paciente_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['paciente_insert'] = paciente_insert.toJson();
    return json;
  }

  CriarPacienteData({
    required this.paciente_insert,
  });
}

@immutable
class CriarPacienteVariables {
  final String nome;
  final String responsavelId;
  late final Optional<DateTime>nascimento;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CriarPacienteVariables.fromJson(Map<String, dynamic> json):
  
  nome = nativeFromJson<String>(json['nome']),
  responsavelId = nativeFromJson<String>(json['responsavelId']) {
  
  
  
  
    nascimento = Optional.optional(nativeFromJson, nativeToJson);
    nascimento.value = json['nascimento'] == null ? null : nativeFromJson<DateTime>(json['nascimento']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CriarPacienteVariables otherTyped = other as CriarPacienteVariables;
    return nome == otherTyped.nome && 
    responsavelId == otherTyped.responsavelId && 
    nascimento == otherTyped.nascimento;
    
  }
  @override
  int get hashCode => Object.hashAll([nome.hashCode, responsavelId.hashCode, nascimento.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nome'] = nativeToJson<String>(nome);
    json['responsavelId'] = nativeToJson<String>(responsavelId);
    if(nascimento.state == OptionalState.set) {
      json['nascimento'] = nascimento.toJson();
    }
    return json;
  }

  CriarPacienteVariables({
    required this.nome,
    required this.responsavelId,
    required this.nascimento,
  });
}

