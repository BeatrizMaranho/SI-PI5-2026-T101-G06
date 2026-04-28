part of 'generated.dart';

class BuscarAlimentoPorLabelVariablesBuilder {
  String label;

  final FirebaseDataConnect _dataConnect;
  BuscarAlimentoPorLabelVariablesBuilder(this._dataConnect, {required  this.label,});
  Deserializer<BuscarAlimentoPorLabelData> dataDeserializer = (dynamic json)  => BuscarAlimentoPorLabelData.fromJson(jsonDecode(json));
  Serializer<BuscarAlimentoPorLabelVariables> varsSerializer = (BuscarAlimentoPorLabelVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<BuscarAlimentoPorLabelData, BuscarAlimentoPorLabelVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<BuscarAlimentoPorLabelData, BuscarAlimentoPorLabelVariables> ref() {
    BuscarAlimentoPorLabelVariables vars= BuscarAlimentoPorLabelVariables(label: label,);
    return _dataConnect.query("BuscarAlimentoPorLabel", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class BuscarAlimentoPorLabelAlimentos {
  final String id;
  final String label;
  final String? categoria;
  BuscarAlimentoPorLabelAlimentos.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
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

    final BuscarAlimentoPorLabelAlimentos otherTyped = other as BuscarAlimentoPorLabelAlimentos;
    return id == otherTyped.id && 
    label == otherTyped.label && 
    categoria == otherTyped.categoria;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, label.hashCode, categoria.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['label'] = nativeToJson<String>(label);
    if (categoria != null) {
      json['categoria'] = nativeToJson<String?>(categoria);
    }
    return json;
  }

  BuscarAlimentoPorLabelAlimentos({
    required this.id,
    required this.label,
    this.categoria,
  });
}

@immutable
class BuscarAlimentoPorLabelData {
  final List<BuscarAlimentoPorLabelAlimentos> alimentos;
  BuscarAlimentoPorLabelData.fromJson(dynamic json):
  
  alimentos = (json['alimentos'] as List<dynamic>)
        .map((e) => BuscarAlimentoPorLabelAlimentos.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final BuscarAlimentoPorLabelData otherTyped = other as BuscarAlimentoPorLabelData;
    return alimentos == otherTyped.alimentos;
    
  }
  @override
  int get hashCode => alimentos.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['alimentos'] = alimentos.map((e) => e.toJson()).toList();
    return json;
  }

  BuscarAlimentoPorLabelData({
    required this.alimentos,
  });
}

@immutable
class BuscarAlimentoPorLabelVariables {
  final String label;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  BuscarAlimentoPorLabelVariables.fromJson(Map<String, dynamic> json):
  
  label = nativeFromJson<String>(json['label']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final BuscarAlimentoPorLabelVariables otherTyped = other as BuscarAlimentoPorLabelVariables;
    return label == otherTyped.label;
    
  }
  @override
  int get hashCode => label.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['label'] = nativeToJson<String>(label);
    return json;
  }

  BuscarAlimentoPorLabelVariables({
    required this.label,
  });
}

