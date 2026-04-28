part of 'generated.dart';

class AtualizarAlimentoVariablesBuilder {
  String id;
  Optional<String> _label = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _categoria = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  AtualizarAlimentoVariablesBuilder label(String? t) {
   _label.value = t;
   return this;
  }
  AtualizarAlimentoVariablesBuilder categoria(String? t) {
   _categoria.value = t;
   return this;
  }

  AtualizarAlimentoVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<AtualizarAlimentoData> dataDeserializer = (dynamic json)  => AtualizarAlimentoData.fromJson(jsonDecode(json));
  Serializer<AtualizarAlimentoVariables> varsSerializer = (AtualizarAlimentoVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AtualizarAlimentoData, AtualizarAlimentoVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AtualizarAlimentoData, AtualizarAlimentoVariables> ref() {
    AtualizarAlimentoVariables vars= AtualizarAlimentoVariables(id: id,label: _label,categoria: _categoria,);
    return _dataConnect.mutation("AtualizarAlimento", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AtualizarAlimentoAlimentoUpdate {
  final String id;
  AtualizarAlimentoAlimentoUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AtualizarAlimentoAlimentoUpdate otherTyped = other as AtualizarAlimentoAlimentoUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AtualizarAlimentoAlimentoUpdate({
    required this.id,
  });
}

@immutable
class AtualizarAlimentoData {
  final AtualizarAlimentoAlimentoUpdate? alimento_update;
  AtualizarAlimentoData.fromJson(dynamic json):
  
  alimento_update = json['alimento_update'] == null ? null : AtualizarAlimentoAlimentoUpdate.fromJson(json['alimento_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AtualizarAlimentoData otherTyped = other as AtualizarAlimentoData;
    return alimento_update == otherTyped.alimento_update;
    
  }
  @override
  int get hashCode => alimento_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (alimento_update != null) {
      json['alimento_update'] = alimento_update!.toJson();
    }
    return json;
  }

  AtualizarAlimentoData({
    this.alimento_update,
  });
}

@immutable
class AtualizarAlimentoVariables {
  final String id;
  late final Optional<String>label;
  late final Optional<String>categoria;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AtualizarAlimentoVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']) {
  
  
  
    label = Optional.optional(nativeFromJson, nativeToJson);
    label.value = json['label'] == null ? null : nativeFromJson<String>(json['label']);
  
  
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

    final AtualizarAlimentoVariables otherTyped = other as AtualizarAlimentoVariables;
    return id == otherTyped.id && 
    label == otherTyped.label && 
    categoria == otherTyped.categoria;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, label.hashCode, categoria.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if(label.state == OptionalState.set) {
      json['label'] = label.toJson();
    }
    if(categoria.state == OptionalState.set) {
      json['categoria'] = categoria.toJson();
    }
    return json;
  }

  AtualizarAlimentoVariables({
    required this.id,
    required this.label,
    required this.categoria,
  });
}

