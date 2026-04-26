part of 'generated.dart';

class ListarDeteccoesPorRefeicaoVariablesBuilder {
  String refeicaoId;

  final FirebaseDataConnect _dataConnect;
  ListarDeteccoesPorRefeicaoVariablesBuilder(this._dataConnect, {required  this.refeicaoId,});
  Deserializer<ListarDeteccoesPorRefeicaoData> dataDeserializer = (dynamic json)  => ListarDeteccoesPorRefeicaoData.fromJson(jsonDecode(json));
  Serializer<ListarDeteccoesPorRefeicaoVariables> varsSerializer = (ListarDeteccoesPorRefeicaoVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListarDeteccoesPorRefeicaoData, ListarDeteccoesPorRefeicaoVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListarDeteccoesPorRefeicaoData, ListarDeteccoesPorRefeicaoVariables> ref() {
    ListarDeteccoesPorRefeicaoVariables vars= ListarDeteccoesPorRefeicaoVariables(refeicaoId: refeicaoId,);
    return _dataConnect.query("ListarDeteccoesPorRefeicao", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListarDeteccoesPorRefeicaoDeteccaoAlimentos {
  final String id;
  final ListarDeteccoesPorRefeicaoDeteccaoAlimentosAlimento alimento;
  final double percentualConsumido;
  final bool aceito;
  final String? cor;
  final String? textura;
  final Timestamp criadoEm;
  ListarDeteccoesPorRefeicaoDeteccaoAlimentos.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  alimento = ListarDeteccoesPorRefeicaoDeteccaoAlimentosAlimento.fromJson(json['alimento']),
  percentualConsumido = nativeFromJson<double>(json['percentualConsumido']),
  aceito = nativeFromJson<bool>(json['aceito']),
  cor = json['cor'] == null ? null : nativeFromJson<String>(json['cor']),
  textura = json['textura'] == null ? null : nativeFromJson<String>(json['textura']),
  criadoEm = Timestamp.fromJson(json['criadoEm']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarDeteccoesPorRefeicaoDeteccaoAlimentos otherTyped = other as ListarDeteccoesPorRefeicaoDeteccaoAlimentos;
    return id == otherTyped.id && 
    alimento == otherTyped.alimento && 
    percentualConsumido == otherTyped.percentualConsumido && 
    aceito == otherTyped.aceito && 
    cor == otherTyped.cor && 
    textura == otherTyped.textura && 
    criadoEm == otherTyped.criadoEm;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, alimento.hashCode, percentualConsumido.hashCode, aceito.hashCode, cor.hashCode, textura.hashCode, criadoEm.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['alimento'] = alimento.toJson();
    json['percentualConsumido'] = nativeToJson<double>(percentualConsumido);
    json['aceito'] = nativeToJson<bool>(aceito);
    if (cor != null) {
      json['cor'] = nativeToJson<String?>(cor);
    }
    if (textura != null) {
      json['textura'] = nativeToJson<String?>(textura);
    }
    json['criadoEm'] = criadoEm.toJson();
    return json;
  }

  ListarDeteccoesPorRefeicaoDeteccaoAlimentos({
    required this.id,
    required this.alimento,
    required this.percentualConsumido,
    required this.aceito,
    this.cor,
    this.textura,
    required this.criadoEm,
  });
}

@immutable
class ListarDeteccoesPorRefeicaoDeteccaoAlimentosAlimento {
  final String label;
  final String? categoria;
  ListarDeteccoesPorRefeicaoDeteccaoAlimentosAlimento.fromJson(dynamic json):
  
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

    final ListarDeteccoesPorRefeicaoDeteccaoAlimentosAlimento otherTyped = other as ListarDeteccoesPorRefeicaoDeteccaoAlimentosAlimento;
    return label == otherTyped.label && 
    categoria == otherTyped.categoria;
    
  }
  @override
  int get hashCode => Object.hashAll([label.hashCode, categoria.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['label'] = nativeToJson<String>(label);
    if (categoria != null) {
      json['categoria'] = nativeToJson<String?>(categoria);
    }
    return json;
  }

  ListarDeteccoesPorRefeicaoDeteccaoAlimentosAlimento({
    required this.label,
    this.categoria,
  });
}

@immutable
class ListarDeteccoesPorRefeicaoData {
  final List<ListarDeteccoesPorRefeicaoDeteccaoAlimentos> deteccaoAlimentos;
  ListarDeteccoesPorRefeicaoData.fromJson(dynamic json):
  
  deteccaoAlimentos = (json['deteccaoAlimentos'] as List<dynamic>)
        .map((e) => ListarDeteccoesPorRefeicaoDeteccaoAlimentos.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarDeteccoesPorRefeicaoData otherTyped = other as ListarDeteccoesPorRefeicaoData;
    return deteccaoAlimentos == otherTyped.deteccaoAlimentos;
    
  }
  @override
  int get hashCode => deteccaoAlimentos.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['deteccaoAlimentos'] = deteccaoAlimentos.map((e) => e.toJson()).toList();
    return json;
  }

  ListarDeteccoesPorRefeicaoData({
    required this.deteccaoAlimentos,
  });
}

@immutable
class ListarDeteccoesPorRefeicaoVariables {
  final String refeicaoId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListarDeteccoesPorRefeicaoVariables.fromJson(Map<String, dynamic> json):
  
  refeicaoId = nativeFromJson<String>(json['refeicaoId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarDeteccoesPorRefeicaoVariables otherTyped = other as ListarDeteccoesPorRefeicaoVariables;
    return refeicaoId == otherTyped.refeicaoId;
    
  }
  @override
  int get hashCode => refeicaoId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['refeicaoId'] = nativeToJson<String>(refeicaoId);
    return json;
  }

  ListarDeteccoesPorRefeicaoVariables({
    required this.refeicaoId,
  });
}

