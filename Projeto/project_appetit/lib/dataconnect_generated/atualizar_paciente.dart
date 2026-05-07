part of 'generated.dart';

class AtualizarPacienteVariablesBuilder {
  String id;
  Optional<String> _nome = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _nascimento = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  AtualizarPacienteVariablesBuilder nome(String? t) {
   _nome.value = t;
   return this;
  }
  AtualizarPacienteVariablesBuilder nascimento(DateTime? t) {
   _nascimento.value = t;
   return this;
  }

  AtualizarPacienteVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<AtualizarPacienteData> dataDeserializer = (dynamic json)  => AtualizarPacienteData.fromJson(jsonDecode(json));
  Serializer<AtualizarPacienteVariables> varsSerializer = (AtualizarPacienteVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AtualizarPacienteData, AtualizarPacienteVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AtualizarPacienteData, AtualizarPacienteVariables> ref() {
    AtualizarPacienteVariables vars= AtualizarPacienteVariables(id: id,nome: _nome,nascimento: _nascimento,);
    return _dataConnect.mutation("AtualizarPaciente", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AtualizarPacientePacienteUpdate {
  final String id;
  AtualizarPacientePacienteUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AtualizarPacientePacienteUpdate otherTyped = other as AtualizarPacientePacienteUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AtualizarPacientePacienteUpdate({
    required this.id,
  });
}

@immutable
class AtualizarPacienteData {
  final AtualizarPacientePacienteUpdate? paciente_update;
  AtualizarPacienteData.fromJson(dynamic json):
  
  paciente_update = json['paciente_update'] == null ? null : AtualizarPacientePacienteUpdate.fromJson(json['paciente_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AtualizarPacienteData otherTyped = other as AtualizarPacienteData;
    return paciente_update == otherTyped.paciente_update;
    
  }
  @override
  int get hashCode => paciente_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (paciente_update != null) {
      json['paciente_update'] = paciente_update!.toJson();
    }
    return json;
  }

  AtualizarPacienteData({
    this.paciente_update,
  });
}

@immutable
class AtualizarPacienteVariables {
  final String id;
  late final Optional<String>nome;
  late final Optional<DateTime>nascimento;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AtualizarPacienteVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']) {
  
  
  
    nome = Optional.optional(nativeFromJson, nativeToJson);
    nome.value = json['nome'] == null ? null : nativeFromJson<String>(json['nome']);
  
  
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

    final AtualizarPacienteVariables otherTyped = other as AtualizarPacienteVariables;
    return id == otherTyped.id && 
    nome == otherTyped.nome && 
    nascimento == otherTyped.nascimento;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, nome.hashCode, nascimento.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if(nome.state == OptionalState.set) {
      json['nome'] = nome.toJson();
    }
    if(nascimento.state == OptionalState.set) {
      json['nascimento'] = nascimento.toJson();
    }
    return json;
  }

  AtualizarPacienteVariables({
    required this.id,
    required this.nome,
    required this.nascimento,
  });
}

