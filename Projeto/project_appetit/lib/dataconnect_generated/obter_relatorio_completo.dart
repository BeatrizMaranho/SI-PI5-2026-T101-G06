part of 'generated.dart';

class ObterRelatorioCompletoVariablesBuilder {
  String relatorioId;

  final FirebaseDataConnect _dataConnect;
  ObterRelatorioCompletoVariablesBuilder(this._dataConnect, {required  this.relatorioId,});
  Deserializer<ObterRelatorioCompletoData> dataDeserializer = (dynamic json)  => ObterRelatorioCompletoData.fromJson(jsonDecode(json));
  Serializer<ObterRelatorioCompletoVariables> varsSerializer = (ObterRelatorioCompletoVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ObterRelatorioCompletoData, ObterRelatorioCompletoVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ObterRelatorioCompletoData, ObterRelatorioCompletoVariables> ref() {
    ObterRelatorioCompletoVariables vars= ObterRelatorioCompletoVariables(relatorioId: relatorioId,);
    return _dataConnect.query("ObterRelatorioCompleto", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ObterRelatorioCompletoRelatorio {
  final String id;
  final String conteudo;
  final Timestamp dataGeracao;
  final ObterRelatorioCompletoRelatorioRefeicao refeicao;
  ObterRelatorioCompletoRelatorio.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  conteudo = nativeFromJson<String>(json['conteudo']),
  dataGeracao = Timestamp.fromJson(json['dataGeracao']),
  refeicao = ObterRelatorioCompletoRelatorioRefeicao.fromJson(json['refeicao']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterRelatorioCompletoRelatorio otherTyped = other as ObterRelatorioCompletoRelatorio;
    return id == otherTyped.id && 
    conteudo == otherTyped.conteudo && 
    dataGeracao == otherTyped.dataGeracao && 
    refeicao == otherTyped.refeicao;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, conteudo.hashCode, dataGeracao.hashCode, refeicao.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['conteudo'] = nativeToJson<String>(conteudo);
    json['dataGeracao'] = dataGeracao.toJson();
    json['refeicao'] = refeicao.toJson();
    return json;
  }

  ObterRelatorioCompletoRelatorio({
    required this.id,
    required this.conteudo,
    required this.dataGeracao,
    required this.refeicao,
  });
}

@immutable
class ObterRelatorioCompletoRelatorioRefeicao {
  final String id;
  final Timestamp dataHora;
  final String urlFotoAntes;
  final String? urlFotoDepois;
  final String status;
  final ObterRelatorioCompletoRelatorioRefeicaoPaciente paciente;
  final List<ObterRelatorioCompletoRelatorioRefeicaoDeteccoes> deteccoes;
  ObterRelatorioCompletoRelatorioRefeicao.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  dataHora = Timestamp.fromJson(json['dataHora']),
  urlFotoAntes = nativeFromJson<String>(json['urlFotoAntes']),
  urlFotoDepois = json['urlFotoDepois'] == null ? null : nativeFromJson<String>(json['urlFotoDepois']),
  status = nativeFromJson<String>(json['status']),
  paciente = ObterRelatorioCompletoRelatorioRefeicaoPaciente.fromJson(json['paciente']),
  deteccoes = (json['deteccoes'] as List<dynamic>)
        .map((e) => ObterRelatorioCompletoRelatorioRefeicaoDeteccoes.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterRelatorioCompletoRelatorioRefeicao otherTyped = other as ObterRelatorioCompletoRelatorioRefeicao;
    return id == otherTyped.id && 
    dataHora == otherTyped.dataHora && 
    urlFotoAntes == otherTyped.urlFotoAntes && 
    urlFotoDepois == otherTyped.urlFotoDepois && 
    status == otherTyped.status && 
    paciente == otherTyped.paciente && 
    deteccoes == otherTyped.deteccoes;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, dataHora.hashCode, urlFotoAntes.hashCode, urlFotoDepois.hashCode, status.hashCode, paciente.hashCode, deteccoes.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['dataHora'] = dataHora.toJson();
    json['urlFotoAntes'] = nativeToJson<String>(urlFotoAntes);
    if (urlFotoDepois != null) {
      json['urlFotoDepois'] = nativeToJson<String?>(urlFotoDepois);
    }
    json['status'] = nativeToJson<String>(status);
    json['paciente'] = paciente.toJson();
    json['deteccoes'] = deteccoes.map((e) => e.toJson()).toList();
    return json;
  }

  ObterRelatorioCompletoRelatorioRefeicao({
    required this.id,
    required this.dataHora,
    required this.urlFotoAntes,
    this.urlFotoDepois,
    required this.status,
    required this.paciente,
    required this.deteccoes,
  });
}

@immutable
class ObterRelatorioCompletoRelatorioRefeicaoPaciente {
  final String nome;
  ObterRelatorioCompletoRelatorioRefeicaoPaciente.fromJson(dynamic json):
  
  nome = nativeFromJson<String>(json['nome']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterRelatorioCompletoRelatorioRefeicaoPaciente otherTyped = other as ObterRelatorioCompletoRelatorioRefeicaoPaciente;
    return nome == otherTyped.nome;
    
  }
  @override
  int get hashCode => nome.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nome'] = nativeToJson<String>(nome);
    return json;
  }

  ObterRelatorioCompletoRelatorioRefeicaoPaciente({
    required this.nome,
  });
}

@immutable
class ObterRelatorioCompletoRelatorioRefeicaoDeteccoes {
  final String id;
  final ObterRelatorioCompletoRelatorioRefeicaoDeteccoesAlimento alimento;
  final double percentualConsumido;
  final bool aceito;
  final String? cor;
  final String? textura;
  ObterRelatorioCompletoRelatorioRefeicaoDeteccoes.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  alimento = ObterRelatorioCompletoRelatorioRefeicaoDeteccoesAlimento.fromJson(json['alimento']),
  percentualConsumido = nativeFromJson<double>(json['percentualConsumido']),
  aceito = nativeFromJson<bool>(json['aceito']),
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

    final ObterRelatorioCompletoRelatorioRefeicaoDeteccoes otherTyped = other as ObterRelatorioCompletoRelatorioRefeicaoDeteccoes;
    return id == otherTyped.id && 
    alimento == otherTyped.alimento && 
    percentualConsumido == otherTyped.percentualConsumido && 
    aceito == otherTyped.aceito && 
    cor == otherTyped.cor && 
    textura == otherTyped.textura;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, alimento.hashCode, percentualConsumido.hashCode, aceito.hashCode, cor.hashCode, textura.hashCode]);
  

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
    return json;
  }

  ObterRelatorioCompletoRelatorioRefeicaoDeteccoes({
    required this.id,
    required this.alimento,
    required this.percentualConsumido,
    required this.aceito,
    this.cor,
    this.textura,
  });
}

@immutable
class ObterRelatorioCompletoRelatorioRefeicaoDeteccoesAlimento {
  final String label;
  final String? categoria;
  ObterRelatorioCompletoRelatorioRefeicaoDeteccoesAlimento.fromJson(dynamic json):
  
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

    final ObterRelatorioCompletoRelatorioRefeicaoDeteccoesAlimento otherTyped = other as ObterRelatorioCompletoRelatorioRefeicaoDeteccoesAlimento;
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

  ObterRelatorioCompletoRelatorioRefeicaoDeteccoesAlimento({
    required this.label,
    this.categoria,
  });
}

@immutable
class ObterRelatorioCompletoData {
  final ObterRelatorioCompletoRelatorio? relatorio;
  ObterRelatorioCompletoData.fromJson(dynamic json):
  
  relatorio = json['relatorio'] == null ? null : ObterRelatorioCompletoRelatorio.fromJson(json['relatorio']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterRelatorioCompletoData otherTyped = other as ObterRelatorioCompletoData;
    return relatorio == otherTyped.relatorio;
    
  }
  @override
  int get hashCode => relatorio.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (relatorio != null) {
      json['relatorio'] = relatorio!.toJson();
    }
    return json;
  }

  ObterRelatorioCompletoData({
    this.relatorio,
  });
}

@immutable
class ObterRelatorioCompletoVariables {
  final String relatorioId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ObterRelatorioCompletoVariables.fromJson(Map<String, dynamic> json):
  
  relatorioId = nativeFromJson<String>(json['relatorioId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterRelatorioCompletoVariables otherTyped = other as ObterRelatorioCompletoVariables;
    return relatorioId == otherTyped.relatorioId;
    
  }
  @override
  int get hashCode => relatorioId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['relatorioId'] = nativeToJson<String>(relatorioId);
    return json;
  }

  ObterRelatorioCompletoVariables({
    required this.relatorioId,
  });
}

