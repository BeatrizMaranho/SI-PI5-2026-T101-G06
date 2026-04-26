part of 'generated.dart';

class CriarDeteccaoVariablesBuilder {
  String refeicaoId;
  String alimentoId;
  double confidence;
  double percentualConsumido;
  Optional<String> _cor = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _textura = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CriarDeteccaoVariablesBuilder cor(String? t) {
   _cor.value = t;
   return this;
  }
  CriarDeteccaoVariablesBuilder textura(String? t) {
   _textura.value = t;
   return this;
  }

  CriarDeteccaoVariablesBuilder(this._dataConnect, {required  this.refeicaoId,required  this.alimentoId,required  this.confidence,required  this.percentualConsumido,});
  Deserializer<CriarDeteccaoData> dataDeserializer = (dynamic json)  => CriarDeteccaoData.fromJson(jsonDecode(json));
  Serializer<CriarDeteccaoVariables> varsSerializer = (CriarDeteccaoVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CriarDeteccaoData, CriarDeteccaoVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CriarDeteccaoData, CriarDeteccaoVariables> ref() {
    CriarDeteccaoVariables vars= CriarDeteccaoVariables(refeicaoId: refeicaoId,alimentoId: alimentoId,confidence: confidence,percentualConsumido: percentualConsumido,cor: _cor,textura: _textura,);
    return _dataConnect.mutation("CriarDeteccao", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CriarDeteccaoDeteccaoAlimentoInsert {
  final String id;
  CriarDeteccaoDeteccaoAlimentoInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CriarDeteccaoDeteccaoAlimentoInsert otherTyped = other as CriarDeteccaoDeteccaoAlimentoInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CriarDeteccaoDeteccaoAlimentoInsert({
    required this.id,
  });
}

@immutable
class CriarDeteccaoData {
  final CriarDeteccaoDeteccaoAlimentoInsert deteccaoAlimento_insert;
  CriarDeteccaoData.fromJson(dynamic json):
  
  deteccaoAlimento_insert = CriarDeteccaoDeteccaoAlimentoInsert.fromJson(json['deteccaoAlimento_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CriarDeteccaoData otherTyped = other as CriarDeteccaoData;
    return deteccaoAlimento_insert == otherTyped.deteccaoAlimento_insert;
    
  }
  @override
  int get hashCode => deteccaoAlimento_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['deteccaoAlimento_insert'] = deteccaoAlimento_insert.toJson();
    return json;
  }

  CriarDeteccaoData({
    required this.deteccaoAlimento_insert,
  });
}

@immutable
class CriarDeteccaoVariables {
  final String refeicaoId;
  final String alimentoId;
  final double confidence;
  final double percentualConsumido;
  late final Optional<String>cor;
  late final Optional<String>textura;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CriarDeteccaoVariables.fromJson(Map<String, dynamic> json):
  
  refeicaoId = nativeFromJson<String>(json['refeicaoId']),
  alimentoId = nativeFromJson<String>(json['alimentoId']),
  confidence = nativeFromJson<double>(json['confidence']),
  percentualConsumido = nativeFromJson<double>(json['percentualConsumido']) {
  
  
  
  
  
  
    cor = Optional.optional(nativeFromJson, nativeToJson);
    cor.value = json['cor'] == null ? null : nativeFromJson<String>(json['cor']);
  
  
    textura = Optional.optional(nativeFromJson, nativeToJson);
    textura.value = json['textura'] == null ? null : nativeFromJson<String>(json['textura']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CriarDeteccaoVariables otherTyped = other as CriarDeteccaoVariables;
    return refeicaoId == otherTyped.refeicaoId && 
    alimentoId == otherTyped.alimentoId && 
    confidence == otherTyped.confidence && 
    percentualConsumido == otherTyped.percentualConsumido && 
    cor == otherTyped.cor && 
    textura == otherTyped.textura;
    
  }
  @override
  int get hashCode => Object.hashAll([refeicaoId.hashCode, alimentoId.hashCode, confidence.hashCode, percentualConsumido.hashCode, cor.hashCode, textura.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['refeicaoId'] = nativeToJson<String>(refeicaoId);
    json['alimentoId'] = nativeToJson<String>(alimentoId);
    json['confidence'] = nativeToJson<double>(confidence);
    json['percentualConsumido'] = nativeToJson<double>(percentualConsumido);
    if(cor.state == OptionalState.set) {
      json['cor'] = cor.toJson();
    }
    if(textura.state == OptionalState.set) {
      json['textura'] = textura.toJson();
    }
    return json;
  }

  CriarDeteccaoVariables({
    required this.refeicaoId,
    required this.alimentoId,
    required this.confidence,
    required this.percentualConsumido,
    required this.cor,
    required this.textura,
  });
}

