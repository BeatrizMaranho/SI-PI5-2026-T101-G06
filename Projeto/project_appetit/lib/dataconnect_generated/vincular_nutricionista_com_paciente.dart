part of 'generated.dart';

class VincularNutricionistaComPacienteVariablesBuilder {
  String nutricionistaId;
  String pacienteId;

  final FirebaseDataConnect _dataConnect;
  VincularNutricionistaComPacienteVariablesBuilder(this._dataConnect, {required  this.nutricionistaId,required  this.pacienteId,});
  Deserializer<VincularNutricionistaComPacienteData> dataDeserializer = (dynamic json)  => VincularNutricionistaComPacienteData.fromJson(jsonDecode(json));
  Serializer<VincularNutricionistaComPacienteVariables> varsSerializer = (VincularNutricionistaComPacienteVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<VincularNutricionistaComPacienteData, VincularNutricionistaComPacienteVariables>> execute() {
    return ref().execute();
  }

  MutationRef<VincularNutricionistaComPacienteData, VincularNutricionistaComPacienteVariables> ref() {
    VincularNutricionistaComPacienteVariables vars= VincularNutricionistaComPacienteVariables(nutricionistaId: nutricionistaId,pacienteId: pacienteId,);
    return _dataConnect.mutation("VincularNutricionistaComPaciente", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class VincularNutricionistaComPacienteNutricionistaPacienteInsert {
  final String nutricionistaId;
  final String pacienteId;
  VincularNutricionistaComPacienteNutricionistaPacienteInsert.fromJson(dynamic json):
  
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

    final VincularNutricionistaComPacienteNutricionistaPacienteInsert otherTyped = other as VincularNutricionistaComPacienteNutricionistaPacienteInsert;
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

  VincularNutricionistaComPacienteNutricionistaPacienteInsert({
    required this.nutricionistaId,
    required this.pacienteId,
  });
}

@immutable
class VincularNutricionistaComPacienteData {
  final VincularNutricionistaComPacienteNutricionistaPacienteInsert nutricionistaPaciente_insert;
  VincularNutricionistaComPacienteData.fromJson(dynamic json):
  
  nutricionistaPaciente_insert = VincularNutricionistaComPacienteNutricionistaPacienteInsert.fromJson(json['nutricionistaPaciente_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final VincularNutricionistaComPacienteData otherTyped = other as VincularNutricionistaComPacienteData;
    return nutricionistaPaciente_insert == otherTyped.nutricionistaPaciente_insert;
    
  }
  @override
  int get hashCode => nutricionistaPaciente_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nutricionistaPaciente_insert'] = nutricionistaPaciente_insert.toJson();
    return json;
  }

  VincularNutricionistaComPacienteData({
    required this.nutricionistaPaciente_insert,
  });
}

@immutable
class VincularNutricionistaComPacienteVariables {
  final String nutricionistaId;
  final String pacienteId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  VincularNutricionistaComPacienteVariables.fromJson(Map<String, dynamic> json):
  
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

    final VincularNutricionistaComPacienteVariables otherTyped = other as VincularNutricionistaComPacienteVariables;
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

  VincularNutricionistaComPacienteVariables({
    required this.nutricionistaId,
    required this.pacienteId,
  });
}

