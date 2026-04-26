part of 'generated.dart';

class AlimentosMaisDetectadosVariablesBuilder {
  String pacienteId;
  Timestamp dataLimite;

  final FirebaseDataConnect _dataConnect;
  AlimentosMaisDetectadosVariablesBuilder(this._dataConnect, {required  this.pacienteId,required  this.dataLimite,});
  Deserializer<AlimentosMaisDetectadosData> dataDeserializer = (dynamic json)  => AlimentosMaisDetectadosData.fromJson(jsonDecode(json));
  Serializer<AlimentosMaisDetectadosVariables> varsSerializer = (AlimentosMaisDetectadosVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<AlimentosMaisDetectadosData, AlimentosMaisDetectadosVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<AlimentosMaisDetectadosData, AlimentosMaisDetectadosVariables> ref() {
    AlimentosMaisDetectadosVariables vars= AlimentosMaisDetectadosVariables(pacienteId: pacienteId,dataLimite: dataLimite,);
    return _dataConnect.query("AlimentosMaisDetectados", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AlimentosMaisDetectadosDeteccaoAlimentos {
  final AlimentosMaisDetectadosDeteccaoAlimentosAlimento alimento;
  final double percentualConsumido;
  AlimentosMaisDetectadosDeteccaoAlimentos.fromJson(dynamic json):
  
  alimento = AlimentosMaisDetectadosDeteccaoAlimentosAlimento.fromJson(json['alimento']),
  percentualConsumido = nativeFromJson<double>(json['percentualConsumido']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AlimentosMaisDetectadosDeteccaoAlimentos otherTyped = other as AlimentosMaisDetectadosDeteccaoAlimentos;
    return alimento == otherTyped.alimento && 
    percentualConsumido == otherTyped.percentualConsumido;
    
  }
  @override
  int get hashCode => Object.hashAll([alimento.hashCode, percentualConsumido.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['alimento'] = alimento.toJson();
    json['percentualConsumido'] = nativeToJson<double>(percentualConsumido);
    return json;
  }

  AlimentosMaisDetectadosDeteccaoAlimentos({
    required this.alimento,
    required this.percentualConsumido,
  });
}

@immutable
class AlimentosMaisDetectadosDeteccaoAlimentosAlimento {
  final String label;
  final String? categoria;
  AlimentosMaisDetectadosDeteccaoAlimentosAlimento.fromJson(dynamic json):
  
  label = nativeFromJson<String>(json['label']),
  categoria = json['categoria'] == null ? null : nativeFromJson<String>(json['categoria']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AlimentosMaisDetectadosDeteccaoAlimentosAlimento otherTyped = other as AlimentosMaisDetectadosDeteccaoAlimentosAlimento;
    return label == otherTyped.label && 
    categoria == otherTyped.categoria;
    
  }
  @override
  int get hashCode => Object.hashAll([label.hashCode, categoria.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['label'] = nativeToJson<String>(label);
    if (categoria != null) {
      json['categoria'] = nativeToJson<String?>(categoria);
    }
    return json;
  }

  AlimentosMaisDetectadosDeteccaoAlimentosAlimento({
    required this.label,
    this.categoria,
  });
}

@immutable
class AlimentosMaisDetectadosData {
  final List<AlimentosMaisDetectadosDeteccaoAlimentos> deteccaoAlimentos;
  AlimentosMaisDetectadosData.fromJson(dynamic json):
  
  deteccaoAlimentos = (json['deteccaoAlimentos'] as List<dynamic>)
        .map((e) => AlimentosMaisDetectadosDeteccaoAlimentos.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AlimentosMaisDetectadosData otherTyped = other as AlimentosMaisDetectadosData;
    return deteccaoAlimentos == otherTyped.deteccaoAlimentos;
    
  }
  @override
  int get hashCode => deteccaoAlimentos.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['deteccaoAlimentos'] = deteccaoAlimentos.map((e) => e.toJson()).toList();
    return json;
  }

  AlimentosMaisDetectadosData({
    required this.deteccaoAlimentos,
  });
}

@immutable
class AlimentosMaisDetectadosVariables {
  final String pacienteId;
  final Timestamp dataLimite;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AlimentosMaisDetectadosVariables.fromJson(Map<String, dynamic> json):
  
  pacienteId = nativeFromJson<String>(json['pacienteId']),
  dataLimite = Timestamp.fromJson(json['dataLimite']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AlimentosMaisDetectadosVariables otherTyped = other as AlimentosMaisDetectadosVariables;
    return pacienteId == otherTyped.pacienteId && 
    dataLimite == otherTyped.dataLimite;
    
  }
  @override
  int get hashCode => Object.hashAll([pacienteId.hashCode, dataLimite.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['pacienteId'] = nativeToJson<String>(pacienteId);
    json['dataLimite'] = dataLimite.toJson();
    return json;
  }

  AlimentosMaisDetectadosVariables({
    required this.pacienteId,
    required this.dataLimite,
  });
}

