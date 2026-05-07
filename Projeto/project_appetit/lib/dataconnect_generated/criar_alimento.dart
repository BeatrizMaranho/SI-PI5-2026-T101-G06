part of 'generated.dart';

class CriarAlimentoVariablesBuilder {
  String label;
  Optional<String> _categoria = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CriarAlimentoVariablesBuilder categoria(String? t) {
   _categoria.value = t;
   return this;
  }

  CriarAlimentoVariablesBuilder(this._dataConnect, {required  this.label,});
  Deserializer<CriarAlimentoData> dataDeserializer = (dynamic json)  => CriarAlimentoData.fromJson(jsonDecode(json));
  Serializer<CriarAlimentoVariables> varsSerializer = (CriarAlimentoVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CriarAlimentoData, CriarAlimentoVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CriarAlimentoData, CriarAlimentoVariables> ref() {
    CriarAlimentoVariables vars= CriarAlimentoVariables(label: label,categoria: _categoria,);
    return _dataConnect.mutation("CriarAlimento", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CriarAlimentoAlimentoInsert {
  final String id;
  CriarAlimentoAlimentoInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CriarAlimentoAlimentoInsert otherTyped = other as CriarAlimentoAlimentoInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CriarAlimentoAlimentoInsert({
    required this.id,
  });
}

@immutable
class CriarAlimentoData {
  final CriarAlimentoAlimentoInsert alimento_insert;
  CriarAlimentoData.fromJson(dynamic json):
  
  alimento_insert = CriarAlimentoAlimentoInsert.fromJson(json['alimento_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CriarAlimentoData otherTyped = other as CriarAlimentoData;
    return alimento_insert == otherTyped.alimento_insert;
    
  }
  @override
  int get hashCode => alimento_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['alimento_insert'] = alimento_insert.toJson();
    return json;
  }

  CriarAlimentoData({
    required this.alimento_insert,
  });
}

@immutable
class CriarAlimentoVariables {
  final String label;
  late final Optional<String>categoria;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CriarAlimentoVariables.fromJson(Map<String, dynamic> json):
  
  label = nativeFromJson<String>(json['label']) {
  
  
  
    categoria = Optional.optional(nativeFromJson, nativeToJson);
    categoria.value = json['categoria'] == null ? null : nativeFromJson<String>(json['categoria']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CriarAlimentoVariables otherTyped = other as CriarAlimentoVariables;
    return label == otherTyped.label && 
    categoria == otherTyped.categoria;
    
  }
  @override
  int get hashCode => Object.hashAll([label.hashCode, categoria.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['label'] = nativeToJson<String>(label);
    if(categoria.state == OptionalState.set) {
      json['categoria'] = categoria.toJson();
    }
    return json;
  }

  CriarAlimentoVariables({
    required this.label,
    required this.categoria,
  });
}

