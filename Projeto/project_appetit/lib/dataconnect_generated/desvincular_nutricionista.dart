part of 'generated.dart';

class DesvincularNutricionistaVariablesBuilder {
  String nutricionistaId;
  String pacienteId;

  final FirebaseDataConnect _dataConnect;
  DesvincularNutricionistaVariablesBuilder(this._dataConnect, {required  this.nutricionistaId,required  this.pacienteId,});
  Deserializer<DesvincularNutricionistaData> dataDeserializer = (dynamic json)  => DesvincularNutricionistaData.fromJson(jsonDecode(json));
  Serializer<DesvincularNutricionistaVariables> varsSerializer = (DesvincularNutricionistaVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DesvincularNutricionistaData, DesvincularNutricionistaVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DesvincularNutricionistaData, DesvincularNutricionistaVariables> ref() {
    DesvincularNutricionistaVariables vars= DesvincularNutricionistaVariables(nutricionistaId: nutricionistaId,pacienteId: pacienteId,);
    return _dataConnect.mutation("DesvincularNutricionista", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DesvincularNutricionistaNutricionistaPacienteDelete {
  final String nutricionistaId;
  final String pacienteId;
  DesvincularNutricionistaNutricionistaPacienteDelete.fromJson(dynamic json):
  
  nutricionistaId = nativeFromJson<String>(json['nutricionistaId']),
  pacienteId = nativeFromJson<String>(json['pacienteId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DesvincularNutricionistaNutricionistaPacienteDelete otherTyped = other as DesvincularNutricionistaNutricionistaPacienteDelete;
    return nutricionistaId == otherTyped.nutricionistaId && 
    pacienteId == otherTyped.pacienteId;
    
  }
  @override
  int get hashCode => Object.hashAll([nutricionistaId.hashCode, pacienteId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nutricionistaId'] = nativeToJson<String>(nutricionistaId);
    json['pacienteId'] = nativeToJson<String>(pacienteId);
    return json;
  }

  DesvincularNutricionistaNutricionistaPacienteDelete({
    required this.nutricionistaId,
    required this.pacienteId,
  });
}

@immutable
class DesvincularNutricionistaData {
  final DesvincularNutricionistaNutricionistaPacienteDelete? nutricionistaPaciente_delete;
  DesvincularNutricionistaData.fromJson(dynamic json):
  
  nutricionistaPaciente_delete = json['nutricionistaPaciente_delete'] == null ? null : DesvincularNutricionistaNutricionistaPacienteDelete.fromJson(json['nutricionistaPaciente_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DesvincularNutricionistaData otherTyped = other as DesvincularNutricionistaData;
    return nutricionistaPaciente_delete == otherTyped.nutricionistaPaciente_delete;
    
  }
  @override
  int get hashCode => nutricionistaPaciente_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (nutricionistaPaciente_delete != null) {
      json['nutricionistaPaciente_delete'] = nutricionistaPaciente_delete!.toJson();
    }
    return json;
  }

  DesvincularNutricionistaData({
    this.nutricionistaPaciente_delete,
  });
}

@immutable
class DesvincularNutricionistaVariables {
  final String nutricionistaId;
  final String pacienteId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DesvincularNutricionistaVariables.fromJson(Map<String, dynamic> json):
  
  nutricionistaId = nativeFromJson<String>(json['nutricionistaId']),
  pacienteId = nativeFromJson<String>(json['pacienteId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DesvincularNutricionistaVariables otherTyped = other as DesvincularNutricionistaVariables;
    return nutricionistaId == otherTyped.nutricionistaId && 
    pacienteId == otherTyped.pacienteId;
    
  }
  @override
  int get hashCode => Object.hashAll([nutricionistaId.hashCode, pacienteId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nutricionistaId'] = nativeToJson<String>(nutricionistaId);
    json['pacienteId'] = nativeToJson<String>(pacienteId);
    return json;
  }

  DesvincularNutricionistaVariables({
    required this.nutricionistaId,
    required this.pacienteId,
  });
}

