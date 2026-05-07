part of 'generated.dart';

class DeletarAlimentoVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeletarAlimentoVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeletarAlimentoData> dataDeserializer = (dynamic json)  => DeletarAlimentoData.fromJson(jsonDecode(json));
  Serializer<DeletarAlimentoVariables> varsSerializer = (DeletarAlimentoVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeletarAlimentoData, DeletarAlimentoVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeletarAlimentoData, DeletarAlimentoVariables> ref() {
    DeletarAlimentoVariables vars= DeletarAlimentoVariables(id: id,);
    return _dataConnect.mutation("DeletarAlimento", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeletarAlimentoAlimentoDelete {
  final String id;
  DeletarAlimentoAlimentoDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletarAlimentoAlimentoDelete otherTyped = other as DeletarAlimentoAlimentoDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeletarAlimentoAlimentoDelete({
    required this.id,
  });
}

@immutable
class DeletarAlimentoData {
  final DeletarAlimentoAlimentoDelete? alimento_delete;
  DeletarAlimentoData.fromJson(dynamic json):
  
  alimento_delete = json['alimento_delete'] == null ? null : DeletarAlimentoAlimentoDelete.fromJson(json['alimento_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletarAlimentoData otherTyped = other as DeletarAlimentoData;
    return alimento_delete == otherTyped.alimento_delete;
    
  }
  @override
  int get hashCode => alimento_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (alimento_delete != null) {
      json['alimento_delete'] = alimento_delete!.toJson();
    }
    return json;
  }

  DeletarAlimentoData({
    this.alimento_delete,
  });
}

@immutable
class DeletarAlimentoVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeletarAlimentoVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletarAlimentoVariables otherTyped = other as DeletarAlimentoVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeletarAlimentoVariables({
    required this.id,
  });
}

