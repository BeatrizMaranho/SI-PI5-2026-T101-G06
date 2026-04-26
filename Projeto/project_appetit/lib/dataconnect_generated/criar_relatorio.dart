part of 'generated.dart';

class CriarRelatorioVariablesBuilder {
  String refeicaoId;
  String pacienteId;
  String conteudo;

  final FirebaseDataConnect _dataConnect;
  CriarRelatorioVariablesBuilder(this._dataConnect, {required  this.refeicaoId,required  this.pacienteId,required  this.conteudo,});
  Deserializer<CriarRelatorioData> dataDeserializer = (dynamic json)  => CriarRelatorioData.fromJson(jsonDecode(json));
  Serializer<CriarRelatorioVariables> varsSerializer = (CriarRelatorioVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CriarRelatorioData, CriarRelatorioVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CriarRelatorioData, CriarRelatorioVariables> ref() {
    CriarRelatorioVariables vars= CriarRelatorioVariables(refeicaoId: refeicaoId,pacienteId: pacienteId,conteudo: conteudo,);
    return _dataConnect.mutation("CriarRelatorio", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CriarRelatorioRelatorioInsert {
  final String id;
  CriarRelatorioRelatorioInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CriarRelatorioRelatorioInsert otherTyped = other as CriarRelatorioRelatorioInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CriarRelatorioRelatorioInsert({
    required this.id,
  });
}

@immutable
class CriarRelatorioData {
  final CriarRelatorioRelatorioInsert relatorio_insert;
  CriarRelatorioData.fromJson(dynamic json):
  
  relatorio_insert = CriarRelatorioRelatorioInsert.fromJson(json['relatorio_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CriarRelatorioData otherTyped = other as CriarRelatorioData;
    return relatorio_insert == otherTyped.relatorio_insert;
    
  }
  @override
  int get hashCode => relatorio_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['relatorio_insert'] = relatorio_insert.toJson();
    return json;
  }

  CriarRelatorioData({
    required this.relatorio_insert,
  });
}

@immutable
class CriarRelatorioVariables {
  final String refeicaoId;
  final String pacienteId;
  final String conteudo;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CriarRelatorioVariables.fromJson(Map<String, dynamic> json):
  
  refeicaoId = nativeFromJson<String>(json['refeicaoId']),
  pacienteId = nativeFromJson<String>(json['pacienteId']),
  conteudo = nativeFromJson<String>(json['conteudo']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CriarRelatorioVariables otherTyped = other as CriarRelatorioVariables;
    return refeicaoId == otherTyped.refeicaoId && 
    pacienteId == otherTyped.pacienteId && 
    conteudo == otherTyped.conteudo;
    
  }
  @override
  int get hashCode => Object.hashAll([refeicaoId.hashCode, pacienteId.hashCode, conteudo.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['refeicaoId'] = nativeToJson<String>(refeicaoId);
    json['pacienteId'] = nativeToJson<String>(pacienteId);
    json['conteudo'] = nativeToJson<String>(conteudo);
    return json;
  }

  CriarRelatorioVariables({
    required this.refeicaoId,
    required this.pacienteId,
    required this.conteudo,
  });
}

