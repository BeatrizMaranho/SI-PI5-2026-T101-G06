part of 'generated.dart';

class DeletarRefeicaoVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeletarRefeicaoVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeletarRefeicaoData> dataDeserializer = (dynamic json)  => DeletarRefeicaoData.fromJson(jsonDecode(json));
  Serializer<DeletarRefeicaoVariables> varsSerializer = (DeletarRefeicaoVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeletarRefeicaoData, DeletarRefeicaoVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeletarRefeicaoData, DeletarRefeicaoVariables> ref() {
    DeletarRefeicaoVariables vars= DeletarRefeicaoVariables(id: id,);
    return _dataConnect.mutation("DeletarRefeicao", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeletarRefeicaoRefeicaoDelete {
  final String id;
  DeletarRefeicaoRefeicaoDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletarRefeicaoRefeicaoDelete otherTyped = other as DeletarRefeicaoRefeicaoDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeletarRefeicaoRefeicaoDelete({
    required this.id,
  });
}

@immutable
class DeletarRefeicaoData {
  final DeletarRefeicaoRefeicaoDelete? refeicao_delete;
  DeletarRefeicaoData.fromJson(dynamic json):
  
  refeicao_delete = json['refeicao_delete'] == null ? null : DeletarRefeicaoRefeicaoDelete.fromJson(json['refeicao_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletarRefeicaoData otherTyped = other as DeletarRefeicaoData;
    return refeicao_delete == otherTyped.refeicao_delete;
    
  }
  @override
  int get hashCode => refeicao_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (refeicao_delete != null) {
      json['refeicao_delete'] = refeicao_delete!.toJson();
    }
    return json;
  }

  DeletarRefeicaoData({
    this.refeicao_delete,
  });
}

@immutable
class DeletarRefeicaoVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeletarRefeicaoVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletarRefeicaoVariables otherTyped = other as DeletarRefeicaoVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeletarRefeicaoVariables({
    required this.id,
  });
}

