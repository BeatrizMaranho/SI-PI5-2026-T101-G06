part of 'generated.dart';

class ObterRefeicaoComDeteccoesVariablesBuilder {
  String refeicaoId;

  final FirebaseDataConnect _dataConnect;
  ObterRefeicaoComDeteccoesVariablesBuilder(this._dataConnect, {required  this.refeicaoId,});
  Deserializer<ObterRefeicaoComDeteccoesData> dataDeserializer = (dynamic json)  => ObterRefeicaoComDeteccoesData.fromJson(jsonDecode(json));
  Serializer<ObterRefeicaoComDeteccoesVariables> varsSerializer = (ObterRefeicaoComDeteccoesVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ObterRefeicaoComDeteccoesData, ObterRefeicaoComDeteccoesVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ObterRefeicaoComDeteccoesData, ObterRefeicaoComDeteccoesVariables> ref() {
    ObterRefeicaoComDeteccoesVariables vars= ObterRefeicaoComDeteccoesVariables(refeicaoId: refeicaoId,);
    return _dataConnect.query("ObterRefeicaoComDeteccoes", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ObterRefeicaoComDeteccoesRefeicao {
  final String id;
  final Timestamp dataHora;
  final String status;
  final String urlFotoAntes;
  final String? urlFotoDepois;
  final ObterRefeicaoComDeteccoesRefeicaoPaciente paciente;
  final List<ObterRefeicaoComDeteccoesRefeicaoDeteccoes> deteccoes;
  ObterRefeicaoComDeteccoesRefeicao.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  dataHora = Timestamp.fromJson(json['dataHora']),
  status = nativeFromJson<String>(json['status']),
  urlFotoAntes = nativeFromJson<String>(json['urlFotoAntes']),
  urlFotoDepois = json['urlFotoDepois'] == null ? null : nativeFromJson<String>(json['urlFotoDepois']),
  paciente = ObterRefeicaoComDeteccoesRefeicaoPaciente.fromJson(json['paciente']),
  deteccoes = (json['deteccoes'] as List<dynamic>)
        .map((e) => ObterRefeicaoComDeteccoesRefeicaoDeteccoes.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterRefeicaoComDeteccoesRefeicao otherTyped = other as ObterRefeicaoComDeteccoesRefeicao;
    return id == otherTyped.id && 
    dataHora == otherTyped.dataHora && 
    status == otherTyped.status && 
    urlFotoAntes == otherTyped.urlFotoAntes && 
    urlFotoDepois == otherTyped.urlFotoDepois && 
    paciente == otherTyped.paciente && 
    deteccoes == otherTyped.deteccoes;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, dataHora.hashCode, status.hashCode, urlFotoAntes.hashCode, urlFotoDepois.hashCode, paciente.hashCode, deteccoes.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['dataHora'] = dataHora.toJson();
    json['status'] = nativeToJson<String>(status);
    json['urlFotoAntes'] = nativeToJson<String>(urlFotoAntes);
    if (urlFotoDepois != null) {
      json['urlFotoDepois'] = nativeToJson<String?>(urlFotoDepois);
    }
    json['paciente'] = paciente.toJson();
    json['deteccoes'] = deteccoes.map((e) => e.toJson()).toList();
    return json;
  }

  ObterRefeicaoComDeteccoesRefeicao({
    required this.id,
    required this.dataHora,
    required this.status,
    required this.urlFotoAntes,
    this.urlFotoDepois,
    required this.paciente,
    required this.deteccoes,
  });
}

@immutable
class ObterRefeicaoComDeteccoesRefeicaoPaciente {
  final String nome;
  ObterRefeicaoComDeteccoesRefeicaoPaciente.fromJson(dynamic json):
  
  nome = nativeFromJson<String>(json['nome']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterRefeicaoComDeteccoesRefeicaoPaciente otherTyped = other as ObterRefeicaoComDeteccoesRefeicaoPaciente;
    return nome == otherTyped.nome;
    
  }
  @override
  int get hashCode => nome.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nome'] = nativeToJson<String>(nome);
    return json;
  }

  ObterRefeicaoComDeteccoesRefeicaoPaciente({
    required this.nome,
  });
}

@immutable
class ObterRefeicaoComDeteccoesRefeicaoDeteccoes {
  final String id;
  final ObterRefeicaoComDeteccoesRefeicaoDeteccoesAlimento alimento;
  final double percentualConsumido;
  final bool aceito;
  final String? cor;
  final String? textura;
  final Timestamp criadoEm;
  ObterRefeicaoComDeteccoesRefeicaoDeteccoes.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  alimento = ObterRefeicaoComDeteccoesRefeicaoDeteccoesAlimento.fromJson(json['alimento']),
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

    final ObterRefeicaoComDeteccoesRefeicaoDeteccoes otherTyped = other as ObterRefeicaoComDeteccoesRefeicaoDeteccoes;
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

  ObterRefeicaoComDeteccoesRefeicaoDeteccoes({
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
class ObterRefeicaoComDeteccoesRefeicaoDeteccoesAlimento {
  final String id;
  final String label;
  final String? categoria;
  ObterRefeicaoComDeteccoesRefeicaoDeteccoesAlimento.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
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

    final ObterRefeicaoComDeteccoesRefeicaoDeteccoesAlimento otherTyped = other as ObterRefeicaoComDeteccoesRefeicaoDeteccoesAlimento;
    return id == otherTyped.id && 
    label == otherTyped.label && 
    categoria == otherTyped.categoria;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, label.hashCode, categoria.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['label'] = nativeToJson<String>(label);
    if (categoria != null) {
      json['categoria'] = nativeToJson<String?>(categoria);
    }
    return json;
  }

  ObterRefeicaoComDeteccoesRefeicaoDeteccoesAlimento({
    required this.id,
    required this.label,
    this.categoria,
  });
}

@immutable
class ObterRefeicaoComDeteccoesData {
  final ObterRefeicaoComDeteccoesRefeicao? refeicao;
  ObterRefeicaoComDeteccoesData.fromJson(dynamic json):
  
  refeicao = json['refeicao'] == null ? null : ObterRefeicaoComDeteccoesRefeicao.fromJson(json['refeicao']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterRefeicaoComDeteccoesData otherTyped = other as ObterRefeicaoComDeteccoesData;
    return refeicao == otherTyped.refeicao;
    
  }
  @override
  int get hashCode => refeicao.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (refeicao != null) {
      json['refeicao'] = refeicao!.toJson();
    }
    return json;
  }

  ObterRefeicaoComDeteccoesData({
    this.refeicao,
  });
}

@immutable
class ObterRefeicaoComDeteccoesVariables {
  final String refeicaoId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ObterRefeicaoComDeteccoesVariables.fromJson(Map<String, dynamic> json):
  
  refeicaoId = nativeFromJson<String>(json['refeicaoId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterRefeicaoComDeteccoesVariables otherTyped = other as ObterRefeicaoComDeteccoesVariables;
    return refeicaoId == otherTyped.refeicaoId;
    
  }
  @override
  int get hashCode => refeicaoId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['refeicaoId'] = nativeToJson<String>(refeicaoId);
    return json;
  }

  ObterRefeicaoComDeteccoesVariables({
    required this.refeicaoId,
  });
}

