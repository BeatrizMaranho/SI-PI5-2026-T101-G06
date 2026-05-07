part of 'generated.dart';

class ListarCatalogoAlimentosVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListarCatalogoAlimentosVariablesBuilder(this._dataConnect, );
  Deserializer<ListarCatalogoAlimentosData> dataDeserializer = (dynamic json)  => ListarCatalogoAlimentosData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListarCatalogoAlimentosData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListarCatalogoAlimentosData, void> ref() {
    
    return _dataConnect.query("ListarCatalogoAlimentos", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListarCatalogoAlimentosAlimentos {
  final String id;
  final String label;
  final String? categoria;
  ListarCatalogoAlimentosAlimentos.fromJson(dynamic json):
  
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

    final ListarCatalogoAlimentosAlimentos otherTyped = other as ListarCatalogoAlimentosAlimentos;
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

  ListarCatalogoAlimentosAlimentos({
    required this.id,
    required this.label,
    this.categoria,
  });
}

@immutable
class ListarCatalogoAlimentosData {
  final List<ListarCatalogoAlimentosAlimentos> alimentos;
  ListarCatalogoAlimentosData.fromJson(dynamic json):
  
  alimentos = (json['alimentos'] as List<dynamic>)
        .map((e) => ListarCatalogoAlimentosAlimentos.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarCatalogoAlimentosData otherTyped = other as ListarCatalogoAlimentosData;
    return alimentos == otherTyped.alimentos;
    
  }
  @override
  int get hashCode => alimentos.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['alimentos'] = alimentos.map((e) => e.toJson()).toList();
    return json;
  }

  ListarCatalogoAlimentosData({
    required this.alimentos,
  });
}

