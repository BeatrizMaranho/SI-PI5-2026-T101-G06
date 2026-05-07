part of 'generated.dart';

class VincularNutricionistaVariablesBuilder {
  String nutricionistaId;
  String pacienteId;

  final FirebaseDataConnect _dataConnect;
  VincularNutricionistaVariablesBuilder(this._dataConnect, {required  this.nutricionistaId,required  this.pacienteId,});
  Deserializer<VincularNutricionistaData> dataDeserializer = (dynamic json)  => VincularNutricionistaData.fromJson(jsonDecode(json));
  Serializer<VincularNutricionistaVariables> varsSerializer = (VincularNutricionistaVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<VincularNutricionistaData, VincularNutricionistaVariables>> execute() {
    return ref().execute();
  }

  MutationRef<VincularNutricionistaData, VincularNutricionistaVariables> ref() {
    VincularNutricionistaVariables vars= VincularNutricionistaVariables(nutricionistaId: nutricionistaId,pacienteId: pacienteId,);
    return _dataConnect.mutation("VincularNutricionista", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class VincularNutricionistaNutricionistaPacienteInsert {
  final String nutricionistaId;
  final String pacienteId;
  VincularNutricionistaNutricionistaPacienteInsert.fromJson(dynamic json):
  
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

    final VincularNutricionistaNutricionistaPacienteInsert otherTyped = other as VincularNutricionistaNutricionistaPacienteInsert;
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

  VincularNutricionistaNutricionistaPacienteInsert({
    required this.nutricionistaId,
    required this.pacienteId,
  });
}

@immutable
class VincularNutricionistaData {
  final VincularNutricionistaNutricionistaPacienteInsert nutricionistaPaciente_insert;
  VincularNutricionistaData.fromJson(dynamic json):
  
  nutricionistaPaciente_insert = VincularNutricionistaNutricionistaPacienteInsert.fromJson(json['nutricionistaPaciente_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final VincularNutricionistaData otherTyped = other as VincularNutricionistaData;
    return nutricionistaPaciente_insert == otherTyped.nutricionistaPaciente_insert;
    
  }
  @override
  int get hashCode => nutricionistaPaciente_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nutricionistaPaciente_insert'] = nutricionistaPaciente_insert.toJson();
    return json;
  }

  VincularNutricionistaData({
    required this.nutricionistaPaciente_insert,
  });
}

@immutable
class VincularNutricionistaVariables {
  final String nutricionistaId;
  final String pacienteId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  VincularNutricionistaVariables.fromJson(Map<String, dynamic> json):
  
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

    final VincularNutricionistaVariables otherTyped = other as VincularNutricionistaVariables;
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

  VincularNutricionistaVariables({
    required this.nutricionistaId,
    required this.pacienteId,
  });
}

