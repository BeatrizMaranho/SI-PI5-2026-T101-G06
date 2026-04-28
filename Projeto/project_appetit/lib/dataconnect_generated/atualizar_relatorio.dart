part of 'generated.dart';

class AtualizarRelatorioVariablesBuilder {
  String id;
  String conteudo;

  final FirebaseDataConnect _dataConnect;
  AtualizarRelatorioVariablesBuilder(this._dataConnect, {required  this.id,required  this.conteudo,});
  Deserializer<AtualizarRelatorioData> dataDeserializer = (dynamic json)  => AtualizarRelatorioData.fromJson(jsonDecode(json));
  Serializer<AtualizarRelatorioVariables> varsSerializer = (AtualizarRelatorioVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AtualizarRelatorioData, AtualizarRelatorioVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AtualizarRelatorioData, AtualizarRelatorioVariables> ref() {
    AtualizarRelatorioVariables vars= AtualizarRelatorioVariables(id: id,conteudo: conteudo,);
    return _dataConnect.mutation("AtualizarRelatorio", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AtualizarRelatorioRelatorioUpdate {
  final String id;
  AtualizarRelatorioRelatorioUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AtualizarRelatorioRelatorioUpdate otherTyped = other as AtualizarRelatorioRelatorioUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AtualizarRelatorioRelatorioUpdate({
    required this.id,
  });
}

@immutable
class AtualizarRelatorioData {
  final AtualizarRelatorioRelatorioUpdate? relatorio_update;
  AtualizarRelatorioData.fromJson(dynamic json):
  
  relatorio_update = json['relatorio_update'] == null ? null : AtualizarRelatorioRelatorioUpdate.fromJson(json['relatorio_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AtualizarRelatorioData otherTyped = other as AtualizarRelatorioData;
    return relatorio_update == otherTyped.relatorio_update;
    
  }
  @override
  int get hashCode => relatorio_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (relatorio_update != null) {
      json['relatorio_update'] = relatorio_update!.toJson();
    }
    return json;
  }

  AtualizarRelatorioData({
    this.relatorio_update,
  });
}

@immutable
class AtualizarRelatorioVariables {
  final String id;
  final String conteudo;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AtualizarRelatorioVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  conteudo = nativeFromJson<String>(json['conteudo']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AtualizarRelatorioVariables otherTyped = other as AtualizarRelatorioVariables;
    return id == otherTyped.id && 
    conteudo == otherTyped.conteudo;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, conteudo.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['conteudo'] = nativeToJson<String>(conteudo);
    return json;
  }

  AtualizarRelatorioVariables({
    required this.id,
    required this.conteudo,
  });
}

