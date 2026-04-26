part of 'generated.dart';

class ListarDeteccoesAceitasPorRefeicaoVariablesBuilder {
  String refeicaoId;

  final FirebaseDataConnect _dataConnect;
  ListarDeteccoesAceitasPorRefeicaoVariablesBuilder(this._dataConnect, {required  this.refeicaoId,});
  Deserializer<ListarDeteccoesAceitasPorRefeicaoData> dataDeserializer = (dynamic json)  => ListarDeteccoesAceitasPorRefeicaoData.fromJson(jsonDecode(json));
  Serializer<ListarDeteccoesAceitasPorRefeicaoVariables> varsSerializer = (ListarDeteccoesAceitasPorRefeicaoVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListarDeteccoesAceitasPorRefeicaoData, ListarDeteccoesAceitasPorRefeicaoVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListarDeteccoesAceitasPorRefeicaoData, ListarDeteccoesAceitasPorRefeicaoVariables> ref() {
    ListarDeteccoesAceitasPorRefeicaoVariables vars= ListarDeteccoesAceitasPorRefeicaoVariables(refeicaoId: refeicaoId,);
    return _dataConnect.query("ListarDeteccoesAceitasPorRefeicao", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListarDeteccoesAceitasPorRefeicaoDeteccaoAlimentos {
  final String id;
  final ListarDeteccoesAceitasPorRefeicaoDeteccaoAlimentosAlimento alimento;
  final double percentualConsumido;
  final String? cor;
  final String? textura;
  ListarDeteccoesAceitasPorRefeicaoDeteccaoAlimentos.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  alimento = ListarDeteccoesAceitasPorRefeicaoDeteccaoAlimentosAlimento.fromJson(json['alimento']),
  percentualConsumido = nativeFromJson<double>(json['percentualConsumido']),
  cor = json['cor'] == null ? null : nativeFromJson<String>(json['cor']),
  textura = json['textura'] == null ? null : nativeFromJson<String>(json['textura']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarDeteccoesAceitasPorRefeicaoDeteccaoAlimentos otherTyped = other as ListarDeteccoesAceitasPorRefeicaoDeteccaoAlimentos;
    return id == otherTyped.id && 
    alimento == otherTyped.alimento && 
    percentualConsumido == otherTyped.percentualConsumido && 
    cor == otherTyped.cor && 
    textura == otherTyped.textura;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, alimento.hashCode, percentualConsumido.hashCode, cor.hashCode, textura.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['alimento'] = alimento.toJson();
    json['percentualConsumido'] = nativeToJson<double>(percentualConsumido);
    if (cor != null) {
      json['cor'] = nativeToJson<String?>(cor);
    }
    if (textura != null) {
      json['textura'] = nativeToJson<String?>(textura);
    }
    return json;
  }

  ListarDeteccoesAceitasPorRefeicaoDeteccaoAlimentos({
    required this.id,
    required this.alimento,
    required this.percentualConsumido,
    this.cor,
    this.textura,
  });
}

@immutable
class ListarDeteccoesAceitasPorRefeicaoDeteccaoAlimentosAlimento {
  final String label;
  final String? categoria;
  ListarDeteccoesAceitasPorRefeicaoDeteccaoAlimentosAlimento.fromJson(dynamic json):
  
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

    final ListarDeteccoesAceitasPorRefeicaoDeteccaoAlimentosAlimento otherTyped = other as ListarDeteccoesAceitasPorRefeicaoDeteccaoAlimentosAlimento;
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

  ListarDeteccoesAceitasPorRefeicaoDeteccaoAlimentosAlimento({
    required this.label,
    this.categoria,
  });
}

@immutable
class ListarDeteccoesAceitasPorRefeicaoData {
  final List<ListarDeteccoesAceitasPorRefeicaoDeteccaoAlimentos> deteccaoAlimentos;
  ListarDeteccoesAceitasPorRefeicaoData.fromJson(dynamic json):
  
  deteccaoAlimentos = (json['deteccaoAlimentos'] as List<dynamic>)
        .map((e) => ListarDeteccoesAceitasPorRefeicaoDeteccaoAlimentos.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarDeteccoesAceitasPorRefeicaoData otherTyped = other as ListarDeteccoesAceitasPorRefeicaoData;
    return deteccaoAlimentos == otherTyped.deteccaoAlimentos;
    
  }
  @override
  int get hashCode => deteccaoAlimentos.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['deteccaoAlimentos'] = deteccaoAlimentos.map((e) => e.toJson()).toList();
    return json;
  }

  ListarDeteccoesAceitasPorRefeicaoData({
    required this.deteccaoAlimentos,
  });
}

@immutable
class ListarDeteccoesAceitasPorRefeicaoVariables {
  final String refeicaoId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListarDeteccoesAceitasPorRefeicaoVariables.fromJson(Map<String, dynamic> json):
  
  refeicaoId = nativeFromJson<String>(json['refeicaoId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarDeteccoesAceitasPorRefeicaoVariables otherTyped = other as ListarDeteccoesAceitasPorRefeicaoVariables;
    return refeicaoId == otherTyped.refeicaoId;
    
  }
  @override
  int get hashCode => refeicaoId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['refeicaoId'] = nativeToJson<String>(refeicaoId);
    return json;
  }

  ListarDeteccoesAceitasPorRefeicaoVariables({
    required this.refeicaoId,
  });
}

