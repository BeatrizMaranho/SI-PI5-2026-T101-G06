part of 'generated.dart';

class DeletarRelatorioVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeletarRelatorioVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeletarRelatorioData> dataDeserializer = (dynamic json)  => DeletarRelatorioData.fromJson(jsonDecode(json));
  Serializer<DeletarRelatorioVariables> varsSerializer = (DeletarRelatorioVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeletarRelatorioData, DeletarRelatorioVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeletarRelatorioData, DeletarRelatorioVariables> ref() {
    DeletarRelatorioVariables vars= DeletarRelatorioVariables(id: id,);
    return _dataConnect.mutation("DeletarRelatorio", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeletarRelatorioRelatorioDelete {
  final String id;
  DeletarRelatorioRelatorioDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletarRelatorioRelatorioDelete otherTyped = other as DeletarRelatorioRelatorioDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeletarRelatorioRelatorioDelete({
    required this.id,
  });
}

@immutable
class DeletarRelatorioData {
  final DeletarRelatorioRelatorioDelete? relatorio_delete;
  DeletarRelatorioData.fromJson(dynamic json):
  
  relatorio_delete = json['relatorio_delete'] == null ? null : DeletarRelatorioRelatorioDelete.fromJson(json['relatorio_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletarRelatorioData otherTyped = other as DeletarRelatorioData;
    return relatorio_delete == otherTyped.relatorio_delete;
    
  }
  @override
  int get hashCode => relatorio_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (relatorio_delete != null) {
      json['relatorio_delete'] = relatorio_delete!.toJson();
    }
    return json;
  }

  DeletarRelatorioData({
    this.relatorio_delete,
  });
}

@immutable
class DeletarRelatorioVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeletarRelatorioVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletarRelatorioVariables otherTyped = other as DeletarRelatorioVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeletarRelatorioVariables({
    required this.id,
  });
}

