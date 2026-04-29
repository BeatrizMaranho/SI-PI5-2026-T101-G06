part of 'generated.dart';

class ObterPacienteParaNutricionistaVariablesBuilder {
  String pacienteId;

  final FirebaseDataConnect _dataConnect;
  ObterPacienteParaNutricionistaVariablesBuilder(this._dataConnect, {required  this.pacienteId,});
  Deserializer<ObterPacienteParaNutricionistaData> dataDeserializer = (dynamic json)  => ObterPacienteParaNutricionistaData.fromJson(jsonDecode(json));
  Serializer<ObterPacienteParaNutricionistaVariables> varsSerializer = (ObterPacienteParaNutricionistaVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ObterPacienteParaNutricionistaData, ObterPacienteParaNutricionistaVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ObterPacienteParaNutricionistaData, ObterPacienteParaNutricionistaVariables> ref() {
    ObterPacienteParaNutricionistaVariables vars= ObterPacienteParaNutricionistaVariables(pacienteId: pacienteId,);
    return _dataConnect.query("ObterPacienteParaNutricionista", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ObterPacienteParaNutricionistaPaciente {
  final String id;
  final String nome;
  final double? peso;
  final String? alergias;
  final DateTime? nascimento;
  final ObterPacienteParaNutricionistaPacienteResponsavel responsavel;
  final List<ObterPacienteParaNutricionistaPacienteRefeicoes> refeicoes;
  ObterPacienteParaNutricionistaPaciente.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  nome = nativeFromJson<String>(json['nome']),
  peso = json['peso'] == null ? null : nativeFromJson<double>(json['peso']),
  alergias = json['alergias'] == null ? null : nativeFromJson<String>(json['alergias']),
  nascimento = json['nascimento'] == null ? null : nativeFromJson<DateTime>(json['nascimento']),
  responsavel = ObterPacienteParaNutricionistaPacienteResponsavel.fromJson(json['responsavel']),
  refeicoes = (json['refeicoes'] as List<dynamic>)
        .map((e) => ObterPacienteParaNutricionistaPacienteRefeicoes.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterPacienteParaNutricionistaPaciente otherTyped = other as ObterPacienteParaNutricionistaPaciente;
    return id == otherTyped.id && 
    nome == otherTyped.nome && 
    peso == otherTyped.peso && 
    alergias == otherTyped.alergias && 
    nascimento == otherTyped.nascimento && 
    responsavel == otherTyped.responsavel && 
    refeicoes == otherTyped.refeicoes;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, nome.hashCode, peso.hashCode, alergias.hashCode, nascimento.hashCode, responsavel.hashCode, refeicoes.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['nome'] = nativeToJson<String>(nome);
    if (peso != null) {
      json['peso'] = nativeToJson<double?>(peso);
    }
    if (alergias != null) {
      json['alergias'] = nativeToJson<String?>(alergias);
    }
    if (nascimento != null) {
      json['nascimento'] = nativeToJson<DateTime?>(nascimento);
    }
    json['responsavel'] = responsavel.toJson();
    json['refeicoes'] = refeicoes.map((e) => e.toJson()).toList();
    return json;
  }

  ObterPacienteParaNutricionistaPaciente({
    required this.id,
    required this.nome,
    this.peso,
    this.alergias,
    this.nascimento,
    required this.responsavel,
    required this.refeicoes,
  });
}

@immutable
class ObterPacienteParaNutricionistaPacienteResponsavel {
  final String nome;
  final String email;
  ObterPacienteParaNutricionistaPacienteResponsavel.fromJson(dynamic json):
  
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

    final ObterPacienteParaNutricionistaPacienteResponsavel otherTyped = other as ObterPacienteParaNutricionistaPacienteResponsavel;
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

  ObterPacienteParaNutricionistaPacienteResponsavel({
    required this.nome,
    required this.email,
  });
}

@immutable
class ObterPacienteParaNutricionistaPacienteRefeicoes {
  final String id;
  final Timestamp dataHora;
  final String status;
  final String urlFotoAntes;
  final String? urlFotoDepois;
  final List<ObterPacienteParaNutricionistaPacienteRefeicoesDeteccoes> deteccoes;
  final List<ObterPacienteParaNutricionistaPacienteRefeicoesRelatorios> relatorios;
  ObterPacienteParaNutricionistaPacienteRefeicoes.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  dataHora = Timestamp.fromJson(json['dataHora']),
  status = nativeFromJson<String>(json['status']),
  urlFotoAntes = nativeFromJson<String>(json['urlFotoAntes']),
  urlFotoDepois = json['urlFotoDepois'] == null ? null : nativeFromJson<String>(json['urlFotoDepois']),
  deteccoes = (json['deteccoes'] as List<dynamic>)
        .map((e) => ObterPacienteParaNutricionistaPacienteRefeicoesDeteccoes.fromJson(e))
        .toList(),
  relatorios = (json['relatorios'] as List<dynamic>)
        .map((e) => ObterPacienteParaNutricionistaPacienteRefeicoesRelatorios.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterPacienteParaNutricionistaPacienteRefeicoes otherTyped = other as ObterPacienteParaNutricionistaPacienteRefeicoes;
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

  ObterPacienteParaNutricionistaPacienteRefeicoes({
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
class ObterPacienteParaNutricionistaPacienteRefeicoesDeteccoes {
  final String id;
  final ObterPacienteParaNutricionistaPacienteRefeicoesDeteccoesAlimento alimento;
  final double percentualConsumido;
  final bool aceito;
  final String? cor;
  final String? textura;
  ObterPacienteParaNutricionistaPacienteRefeicoesDeteccoes.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  alimento = ObterPacienteParaNutricionistaPacienteRefeicoesDeteccoesAlimento.fromJson(json['alimento']),
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

    final ObterPacienteParaNutricionistaPacienteRefeicoesDeteccoes otherTyped = other as ObterPacienteParaNutricionistaPacienteRefeicoesDeteccoes;
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

  ObterPacienteParaNutricionistaPacienteRefeicoesDeteccoes({
    required this.id,
    required this.alimento,
    required this.percentualConsumido,
    required this.aceito,
    this.cor,
    this.textura,
  });
}

@immutable
class ObterPacienteParaNutricionistaPacienteRefeicoesDeteccoesAlimento {
  final String label;
  final String? categoria;
  ObterPacienteParaNutricionistaPacienteRefeicoesDeteccoesAlimento.fromJson(dynamic json):
  
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

    final ObterPacienteParaNutricionistaPacienteRefeicoesDeteccoesAlimento otherTyped = other as ObterPacienteParaNutricionistaPacienteRefeicoesDeteccoesAlimento;
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

  ObterPacienteParaNutricionistaPacienteRefeicoesDeteccoesAlimento({
    required this.label,
    this.categoria,
  });
}

@immutable
class ObterPacienteParaNutricionistaPacienteRefeicoesRelatorios {
  final String id;
  final String conteudo;
  final Timestamp dataGeracao;
  ObterPacienteParaNutricionistaPacienteRefeicoesRelatorios.fromJson(dynamic json):
  
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

    final ObterPacienteParaNutricionistaPacienteRefeicoesRelatorios otherTyped = other as ObterPacienteParaNutricionistaPacienteRefeicoesRelatorios;
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

  ObterPacienteParaNutricionistaPacienteRefeicoesRelatorios({
    required this.id,
    required this.conteudo,
    required this.dataGeracao,
  });
}

@immutable
class ObterPacienteParaNutricionistaData {
  final ObterPacienteParaNutricionistaPaciente? paciente;
  ObterPacienteParaNutricionistaData.fromJson(dynamic json):
  
  paciente = json['paciente'] == null ? null : ObterPacienteParaNutricionistaPaciente.fromJson(json['paciente']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterPacienteParaNutricionistaData otherTyped = other as ObterPacienteParaNutricionistaData;
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

  ObterPacienteParaNutricionistaData({
    this.paciente,
  });
}

@immutable
class ObterPacienteParaNutricionistaVariables {
  final String pacienteId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ObterPacienteParaNutricionistaVariables.fromJson(Map<String, dynamic> json):
  
  pacienteId = nativeFromJson<String>(json['pacienteId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterPacienteParaNutricionistaVariables otherTyped = other as ObterPacienteParaNutricionistaVariables;
    return pacienteId == otherTyped.pacienteId;
    
  }
  @override
  int get hashCode => pacienteId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['pacienteId'] = nativeToJson<String>(pacienteId);
    return json;
  }

  ObterPacienteParaNutricionistaVariables({
    required this.pacienteId,
  });
}

