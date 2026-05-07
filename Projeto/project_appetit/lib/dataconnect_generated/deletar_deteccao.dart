part of 'generated.dart';

class DeletarDeteccaoVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeletarDeteccaoVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeletarDeteccaoData> dataDeserializer = (dynamic json)  => DeletarDeteccaoData.fromJson(jsonDecode(json));
  Serializer<DeletarDeteccaoVariables> varsSerializer = (DeletarDeteccaoVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeletarDeteccaoData, DeletarDeteccaoVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeletarDeteccaoData, DeletarDeteccaoVariables> ref() {
    DeletarDeteccaoVariables vars= DeletarDeteccaoVariables(id: id,);
    return _dataConnect.mutation("DeletarDeteccao", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeletarDeteccaoDeteccaoAlimentoDelete {
  final String id;
  DeletarDeteccaoDeteccaoAlimentoDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletarDeteccaoDeteccaoAlimentoDelete otherTyped = other as DeletarDeteccaoDeteccaoAlimentoDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeletarDeteccaoDeteccaoAlimentoDelete({
    required this.id,
  });
}

@immutable
class DeletarDeteccaoData {
  final DeletarDeteccaoDeteccaoAlimentoDelete? deteccaoAlimento_delete;
  DeletarDeteccaoData.fromJson(dynamic json):
  
  deteccaoAlimento_delete = json['deteccaoAlimento_delete'] == null ? null : DeletarDeteccaoDeteccaoAlimentoDelete.fromJson(json['deteccaoAlimento_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletarDeteccaoData otherTyped = other as DeletarDeteccaoData;
    return deteccaoAlimento_delete == otherTyped.deteccaoAlimento_delete;
    
  }
  @override
  int get hashCode => deteccaoAlimento_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (deteccaoAlimento_delete != null) {
      json['deteccaoAlimento_delete'] = deteccaoAlimento_delete!.toJson();
    }
    return json;
  }

  DeletarDeteccaoData({
    this.deteccaoAlimento_delete,
  });
}

@immutable
class DeletarDeteccaoVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeletarDeteccaoVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletarDeteccaoVariables otherTyped = other as DeletarDeteccaoVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeletarDeteccaoVariables({
    required this.id,
  });
}

