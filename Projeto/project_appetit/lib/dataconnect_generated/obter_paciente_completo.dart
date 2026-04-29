part of 'generated.dart';

class ObterPacienteCompletoVariablesBuilder {
  String pacienteId;

  final FirebaseDataConnect _dataConnect;
  ObterPacienteCompletoVariablesBuilder(this._dataConnect, {required  this.pacienteId,});
  Deserializer<ObterPacienteCompletoData> dataDeserializer = (dynamic json)  => ObterPacienteCompletoData.fromJson(jsonDecode(json));
  Serializer<ObterPacienteCompletoVariables> varsSerializer = (ObterPacienteCompletoVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ObterPacienteCompletoData, ObterPacienteCompletoVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ObterPacienteCompletoData, ObterPacienteCompletoVariables> ref() {
    ObterPacienteCompletoVariables vars= ObterPacienteCompletoVariables(pacienteId: pacienteId,);
    return _dataConnect.query("ObterPacienteCompleto", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ObterPacienteCompletoPaciente {
  final String id;
  final String nome;
  final DateTime? nascimento;
  final double? peso;
  final String? alergias;
  final ObterPacienteCompletoPacienteResponsavel responsavel;
  final List<ObterPacienteCompletoPacienteRefeicoes> refeicoes;
  ObterPacienteCompletoPaciente.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  nome = nativeFromJson<String>(json['nome']),
  nascimento = json['nascimento'] == null ? null : nativeFromJson<DateTime>(json['nascimento']),
  peso = json['peso'] == null ? null : nativeFromJson<double>(json['peso']),
  alergias = json['alergias'] == null ? null : nativeFromJson<String>(json['alergias']),
  responsavel = ObterPacienteCompletoPacienteResponsavel.fromJson(json['responsavel']),
  refeicoes = (json['refeicoes'] as List<dynamic>)
        .map((e) => ObterPacienteCompletoPacienteRefeicoes.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterPacienteCompletoPaciente otherTyped = other as ObterPacienteCompletoPaciente;
    return id == otherTyped.id && 
    nome == otherTyped.nome && 
    nascimento == otherTyped.nascimento && 
    peso == otherTyped.peso && 
    alergias == otherTyped.alergias && 
    responsavel == otherTyped.responsavel && 
    refeicoes == otherTyped.refeicoes;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, nome.hashCode, nascimento.hashCode, peso.hashCode, alergias.hashCode, responsavel.hashCode, refeicoes.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['nome'] = nativeToJson<String>(nome);
    if (nascimento != null) {
      json['nascimento'] = nativeToJson<DateTime?>(nascimento);
    }
    if (peso != null) {
      json['peso'] = nativeToJson<double?>(peso);
    }
    if (alergias != null) {
      json['alergias'] = nativeToJson<String?>(alergias);
    }
    json['responsavel'] = responsavel.toJson();
    json['refeicoes'] = refeicoes.map((e) => e.toJson()).toList();
    return json;
  }

  ObterPacienteCompletoPaciente({
    required this.id,
    required this.nome,
    this.nascimento,
    this.peso,
    this.alergias,
    required this.responsavel,
    required this.refeicoes,
  });
}

@immutable
class ObterPacienteCompletoPacienteResponsavel {
  final String nome;
  final String email;
  ObterPacienteCompletoPacienteResponsavel.fromJson(dynamic json):
  
  nome = nativeFromJson<String>(json['nome']),
  email = nativeFromJson<String>(json['email']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterPacienteCompletoPacienteResponsavel otherTyped = other as ObterPacienteCompletoPacienteResponsavel;
    return nome == otherTyped.nome && 
    email == otherTyped.email;
    
  }
  @override
  int get hashCode => Object.hashAll([nome.hashCode, email.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nome'] = nativeToJson<String>(nome);
    json['email'] = nativeToJson<String>(email);
    return json;
  }

  ObterPacienteCompletoPacienteResponsavel({
    required this.nome,
    required this.email,
  });
}

@immutable
class ObterPacienteCompletoPacienteRefeicoes {
  final String id;
  final Timestamp dataHora;
  final String status;
  final String urlFotoAntes;
  final String? urlFotoDepois;
  final List<ObterPacienteCompletoPacienteRefeicoesDeteccoes> deteccoes;
  final List<ObterPacienteCompletoPacienteRefeicoesRelatorios> relatorios;
  ObterPacienteCompletoPacienteRefeicoes.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  dataHora = Timestamp.fromJson(json['dataHora']),
  status = nativeFromJson<String>(json['status']),
  urlFotoAntes = nativeFromJson<String>(json['urlFotoAntes']),
  urlFotoDepois = json['urlFotoDepois'] == null ? null : nativeFromJson<String>(json['urlFotoDepois']),
  deteccoes = (json['deteccoes'] as List<dynamic>)
        .map((e) => ObterPacienteCompletoPacienteRefeicoesDeteccoes.fromJson(e))
        .toList(),
  relatorios = (json['relatorios'] as List<dynamic>)
        .map((e) => ObterPacienteCompletoPacienteRefeicoesRelatorios.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterPacienteCompletoPacienteRefeicoes otherTyped = other as ObterPacienteCompletoPacienteRefeicoes;
    return id == otherTyped.id && 
    dataHora == otherTyped.dataHora && 
    status == otherTyped.status && 
    urlFotoAntes == otherTyped.urlFotoAntes && 
    urlFotoDepois == otherTyped.urlFotoDepois && 
    deteccoes == otherTyped.deteccoes && 
    relatorios == otherTyped.relatorios;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, dataHora.hashCode, status.hashCode, urlFotoAntes.hashCode, urlFotoDepois.hashCode, deteccoes.hashCode, relatorios.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['dataHora'] = dataHora.toJson();
    json['status'] = nativeToJson<String>(status);
    json['urlFotoAntes'] = nativeToJson<String>(urlFotoAntes);
    if (urlFotoDepois != null) {
      json['urlFotoDepois'] = nativeToJson<String?>(urlFotoDepois);
    }
    json['deteccoes'] = deteccoes.map((e) => e.toJson()).toList();
    json['relatorios'] = relatorios.map((e) => e.toJson()).toList();
    return json;
  }

  ObterPacienteCompletoPacienteRefeicoes({
    required this.id,
    required this.dataHora,
    required this.status,
    required this.urlFotoAntes,
    this.urlFotoDepois,
    required this.deteccoes,
    required this.relatorios,
  });
}

@immutable
class ObterPacienteCompletoPacienteRefeicoesDeteccoes {
  final String id;
  final ObterPacienteCompletoPacienteRefeicoesDeteccoesAlimento alimento;
  final double percentualConsumido;
  final bool aceito;
  final String? cor;
  final String? textura;
  ObterPacienteCompletoPacienteRefeicoesDeteccoes.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  alimento = ObterPacienteCompletoPacienteRefeicoesDeteccoesAlimento.fromJson(json['alimento']),
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

    final ObterPacienteCompletoPacienteRefeicoesDeteccoes otherTyped = other as ObterPacienteCompletoPacienteRefeicoesDeteccoes;
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

  ObterPacienteCompletoPacienteRefeicoesDeteccoes({
    required this.id,
    required this.alimento,
    required this.percentualConsumido,
    required this.aceito,
    this.cor,
    this.textura,
  });
}

@immutable
class ObterPacienteCompletoPacienteRefeicoesDeteccoesAlimento {
  final String label;
  final String? categoria;
  ObterPacienteCompletoPacienteRefeicoesDeteccoesAlimento.fromJson(dynamic json):
  
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

    final ObterPacienteCompletoPacienteRefeicoesDeteccoesAlimento otherTyped = other as ObterPacienteCompletoPacienteRefeicoesDeteccoesAlimento;
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

  ObterPacienteCompletoPacienteRefeicoesDeteccoesAlimento({
    required this.label,
    this.categoria,
  });
}

@immutable
class ObterPacienteCompletoPacienteRefeicoesRelatorios {
  final String id;
  final String conteudo;
  final Timestamp dataGeracao;
  ObterPacienteCompletoPacienteRefeicoesRelatorios.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  conteudo = nativeFromJson<String>(json['conteudo']),
  dataGeracao = Timestamp.fromJson(json['dataGeracao']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterPacienteCompletoPacienteRefeicoesRelatorios otherTyped = other as ObterPacienteCompletoPacienteRefeicoesRelatorios;
    return id == otherTyped.id && 
    conteudo == otherTyped.conteudo && 
    dataGeracao == otherTyped.dataGeracao;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, conteudo.hashCode, dataGeracao.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['conteudo'] = nativeToJson<String>(conteudo);
    json['dataGeracao'] = dataGeracao.toJson();
    return json;
  }

  ObterPacienteCompletoPacienteRefeicoesRelatorios({
    required this.id,
    required this.conteudo,
    required this.dataGeracao,
  });
}

@immutable
class ObterPacienteCompletoData {
  final ObterPacienteCompletoPaciente? paciente;
  ObterPacienteCompletoData.fromJson(dynamic json):
  
  paciente = json['paciente'] == null ? null : ObterPacienteCompletoPaciente.fromJson(json['paciente']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterPacienteCompletoData otherTyped = other as ObterPacienteCompletoData;
    return paciente == otherTyped.paciente;
    
  }
  @override
  int get hashCode => paciente.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (paciente != null) {
      json['paciente'] = paciente!.toJson();
    }
    return json;
  }

  ObterPacienteCompletoData({
    this.paciente,
  });
}

@immutable
class ObterPacienteCompletoVariables {
  final String pacienteId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ObterPacienteCompletoVariables.fromJson(Map<String, dynamic> json):
  
  pacienteId = nativeFromJson<String>(json['pacienteId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterPacienteCompletoVariables otherTyped = other as ObterPacienteCompletoVariables;
    return pacienteId == otherTyped.pacienteId;
    
  }
  @override
  int get hashCode => pacienteId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['pacienteId'] = nativeToJson<String>(pacienteId);
    return json;
  }

  ObterPacienteCompletoVariables({
    required this.pacienteId,
  });
}

