part of 'generated.dart';

class ListarAlimentosPorCategoriaVariablesBuilder {
  String categoria;

  final FirebaseDataConnect _dataConnect;
  ListarAlimentosPorCategoriaVariablesBuilder(this._dataConnect, {required  this.categoria,});
  Deserializer<ListarAlimentosPorCategoriaData> dataDeserializer = (dynamic json)  => ListarAlimentosPorCategoriaData.fromJson(jsonDecode(json));
  Serializer<ListarAlimentosPorCategoriaVariables> varsSerializer = (ListarAlimentosPorCategoriaVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListarAlimentosPorCategoriaData, ListarAlimentosPorCategoriaVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListarAlimentosPorCategoriaData, ListarAlimentosPorCategoriaVariables> ref() {
    ListarAlimentosPorCategoriaVariables vars= ListarAlimentosPorCategoriaVariables(categoria: categoria,);
    return _dataConnect.query("ListarAlimentosPorCategoria", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListarAlimentosPorCategoriaAlimentos {
  final String id;
  final String label;
  final String? categoria;
  ListarAlimentosPorCategoriaAlimentos.fromJson(dynamic json):
  
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

    final ListarAlimentosPorCategoriaAlimentos otherTyped = other as ListarAlimentosPorCategoriaAlimentos;
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

  ListarAlimentosPorCategoriaAlimentos({
    required this.id,
    required this.label,
    this.categoria,
  });
}

@immutable
class ListarAlimentosPorCategoriaData {
  final List<ListarAlimentosPorCategoriaAlimentos> alimentos;
  ListarAlimentosPorCategoriaData.fromJson(dynamic json):
  
  alimentos = (json['alimentos'] as List<dynamic>)
        .map((e) => ListarAlimentosPorCategoriaAlimentos.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarAlimentosPorCategoriaData otherTyped = other as ListarAlimentosPorCategoriaData;
    return alimentos == otherTyped.alimentos;
    
  }
  @override
  int get hashCode => alimentos.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['alimentos'] = alimentos.map((e) => e.toJson()).toList();
    return json;
  }

  ListarAlimentosPorCategoriaData({
    required this.alimentos,
  });
}

@immutable
class ListarAlimentosPorCategoriaVariables {
  final String categoria;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListarAlimentosPorCategoriaVariables.fromJson(Map<String, dynamic> json):
  
  categoria = nativeFromJson<String>(json['categoria']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarAlimentosPorCategoriaVariables otherTyped = other as ListarAlimentosPorCategoriaVariables;
    return categoria == otherTyped.categoria;
    
  }
  @override
  int get hashCode => categoria.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['categoria'] = nativeToJson<String>(categoria);
    return json;
  }

  ListarAlimentosPorCategoriaVariables({
    required this.categoria,
  });
}

