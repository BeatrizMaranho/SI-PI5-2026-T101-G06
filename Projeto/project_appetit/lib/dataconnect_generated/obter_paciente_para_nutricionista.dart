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
  ObterPacienteParaNutricionistaPacienteRefeicoes.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  dataHora = Timestamp.fromJson(json['dataHora']),
  status = nativeFromJson<String>(json['status']),
  urlFotoAntes = nativeFromJson<String>(json['urlFotoAntes']),
  urlFotoDepois = json['urlFotoDepois'] == null ? null : nativeFromJson<String>(json['urlFotoDepois']);
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
    urlFotoDepois == otherTyped.urlFotoDepois;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, dataHora.hashCode, status.hashCode, urlFotoAntes.hashCode, urlFotoDepois.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['dataHora'] = dataHora.toJson();
    json['status'] = nativeToJson<String>(status);
    json['urlFotoAntes'] = nativeToJson<String>(urlFotoAntes);
    if (urlFotoDepois != null) {
      json['urlFotoDepois'] = nativeToJson<String?>(urlFotoDepois);
    }
    return json;
  }

  ObterPacienteParaNutricionistaPacienteRefeicoes({
    required this.id,
    required this.dataHora,
    required this.status,
    required this.urlFotoAntes,
    this.urlFotoDepois,
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

