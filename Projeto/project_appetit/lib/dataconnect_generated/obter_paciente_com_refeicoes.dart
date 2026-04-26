part of 'generated.dart';

class ObterPacienteComRefeicoesVariablesBuilder {
  String pacienteId;

  final FirebaseDataConnect _dataConnect;
  ObterPacienteComRefeicoesVariablesBuilder(this._dataConnect, {required  this.pacienteId,});
  Deserializer<ObterPacienteComRefeicoesData> dataDeserializer = (dynamic json)  => ObterPacienteComRefeicoesData.fromJson(jsonDecode(json));
  Serializer<ObterPacienteComRefeicoesVariables> varsSerializer = (ObterPacienteComRefeicoesVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ObterPacienteComRefeicoesData, ObterPacienteComRefeicoesVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ObterPacienteComRefeicoesData, ObterPacienteComRefeicoesVariables> ref() {
    ObterPacienteComRefeicoesVariables vars= ObterPacienteComRefeicoesVariables(pacienteId: pacienteId,);
    return _dataConnect.query("ObterPacienteComRefeicoes", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ObterPacienteComRefeicoesPaciente {
  final String id;
  final String nome;
  final DateTime? nascimento;
  final ObterPacienteComRefeicoesPacienteResponsavel responsavel;
  final List<ObterPacienteComRefeicoesPacienteRefeicoes> refeicoes;
  ObterPacienteComRefeicoesPaciente.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  nome = nativeFromJson<String>(json['nome']),
  nascimento = json['nascimento'] == null ? null : nativeFromJson<DateTime>(json['nascimento']),
  responsavel = ObterPacienteComRefeicoesPacienteResponsavel.fromJson(json['responsavel']),
  refeicoes = (json['refeicoes'] as List<dynamic>)
        .map((e) => ObterPacienteComRefeicoesPacienteRefeicoes.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterPacienteComRefeicoesPaciente otherTyped = other as ObterPacienteComRefeicoesPaciente;
    return id == otherTyped.id && 
    nome == otherTyped.nome && 
    nascimento == otherTyped.nascimento && 
    responsavel == otherTyped.responsavel && 
    refeicoes == otherTyped.refeicoes;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, nome.hashCode, nascimento.hashCode, responsavel.hashCode, refeicoes.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['nome'] = nativeToJson<String>(nome);
    if (nascimento != null) {
      json['nascimento'] = nativeToJson<DateTime?>(nascimento);
    }
    json['responsavel'] = responsavel.toJson();
    json['refeicoes'] = refeicoes.map((e) => e.toJson()).toList();
    return json;
  }

  ObterPacienteComRefeicoesPaciente({
    required this.id,
    required this.nome,
    this.nascimento,
    required this.responsavel,
    required this.refeicoes,
  });
}

@immutable
class ObterPacienteComRefeicoesPacienteResponsavel {
  final String nome;
  final String email;
  ObterPacienteComRefeicoesPacienteResponsavel.fromJson(dynamic json):
  
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

    final ObterPacienteComRefeicoesPacienteResponsavel otherTyped = other as ObterPacienteComRefeicoesPacienteResponsavel;
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

  ObterPacienteComRefeicoesPacienteResponsavel({
    required this.nome,
    required this.email,
  });
}

@immutable
class ObterPacienteComRefeicoesPacienteRefeicoes {
  final String id;
  final Timestamp dataHora;
  final String status;
  final String urlFotoAntes;
  final String? urlFotoDepois;
  ObterPacienteComRefeicoesPacienteRefeicoes.fromJson(dynamic json):
  
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

    final ObterPacienteComRefeicoesPacienteRefeicoes otherTyped = other as ObterPacienteComRefeicoesPacienteRefeicoes;
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

  ObterPacienteComRefeicoesPacienteRefeicoes({
    required this.id,
    required this.dataHora,
    required this.status,
    required this.urlFotoAntes,
    this.urlFotoDepois,
  });
}

@immutable
class ObterPacienteComRefeicoesData {
  final ObterPacienteComRefeicoesPaciente? paciente;
  ObterPacienteComRefeicoesData.fromJson(dynamic json):
  
  paciente = json['paciente'] == null ? null : ObterPacienteComRefeicoesPaciente.fromJson(json['paciente']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterPacienteComRefeicoesData otherTyped = other as ObterPacienteComRefeicoesData;
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

  ObterPacienteComRefeicoesData({
    this.paciente,
  });
}

@immutable
class ObterPacienteComRefeicoesVariables {
  final String pacienteId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ObterPacienteComRefeicoesVariables.fromJson(Map<String, dynamic> json):
  
  pacienteId = nativeFromJson<String>(json['pacienteId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ObterPacienteComRefeicoesVariables otherTyped = other as ObterPacienteComRefeicoesVariables;
    return pacienteId == otherTyped.pacienteId;
    
  }
  @override
  int get hashCode => pacienteId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['pacienteId'] = nativeToJson<String>(pacienteId);
    return json;
  }

  ObterPacienteComRefeicoesVariables({
    required this.pacienteId,
  });
}

