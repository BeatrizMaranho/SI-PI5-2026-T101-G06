part of 'generated.dart';

class DeletarPacienteVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeletarPacienteVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeletarPacienteData> dataDeserializer = (dynamic json)  => DeletarPacienteData.fromJson(jsonDecode(json));
  Serializer<DeletarPacienteVariables> varsSerializer = (DeletarPacienteVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeletarPacienteData, DeletarPacienteVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeletarPacienteData, DeletarPacienteVariables> ref() {
    DeletarPacienteVariables vars= DeletarPacienteVariables(id: id,);
    return _dataConnect.mutation("DeletarPaciente", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeletarPacientePacienteDelete {
  final String id;
  DeletarPacientePacienteDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletarPacientePacienteDelete otherTyped = other as DeletarPacientePacienteDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeletarPacientePacienteDelete({
    required this.id,
  });
}

@immutable
class DeletarPacienteData {
  final DeletarPacientePacienteDelete? paciente_delete;
  DeletarPacienteData.fromJson(dynamic json):
  
  paciente_delete = json['paciente_delete'] == null ? null : DeletarPacientePacienteDelete.fromJson(json['paciente_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletarPacienteData otherTyped = other as DeletarPacienteData;
    return paciente_delete == otherTyped.paciente_delete;
    
  }
  @override
  int get hashCode => paciente_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (paciente_delete != null) {
      json['paciente_delete'] = paciente_delete!.toJson();
    }
    return json;
  }

  DeletarPacienteData({
    this.paciente_delete,
  });
}

@immutable
class DeletarPacienteVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeletarPacienteVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletarPacienteVariables otherTyped = other as DeletarPacienteVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeletarPacienteVariables({
    required this.id,
  });
}

