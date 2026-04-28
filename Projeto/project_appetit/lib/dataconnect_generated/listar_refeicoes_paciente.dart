part of 'generated.dart';

class ListarRefeicoesPacienteVariablesBuilder {
  String pacienteId;
  Optional<String> _status = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  ListarRefeicoesPacienteVariablesBuilder status(String? t) {
   _status.value = t;
   return this;
  }

  ListarRefeicoesPacienteVariablesBuilder(this._dataConnect, {required  this.pacienteId,});
  Deserializer<ListarRefeicoesPacienteData> dataDeserializer = (dynamic json)  => ListarRefeicoesPacienteData.fromJson(jsonDecode(json));
  Serializer<ListarRefeicoesPacienteVariables> varsSerializer = (ListarRefeicoesPacienteVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListarRefeicoesPacienteData, ListarRefeicoesPacienteVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListarRefeicoesPacienteData, ListarRefeicoesPacienteVariables> ref() {
    ListarRefeicoesPacienteVariables vars= ListarRefeicoesPacienteVariables(pacienteId: pacienteId,status: _status,);
    return _dataConnect.query("ListarRefeicoesPaciente", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListarRefeicoesPacienteRefeicaos {
  final String id;
  final Timestamp dataHora;
  final String status;
  final String urlFotoAntes;
  final String? urlFotoDepois;
  final ListarRefeicoesPacienteRefeicaosPaciente paciente;
  ListarRefeicoesPacienteRefeicaos.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  dataHora = Timestamp.fromJson(json['dataHora']),
  status = nativeFromJson<String>(json['status']),
  urlFotoAntes = nativeFromJson<String>(json['urlFotoAntes']),
  urlFotoDepois = json['urlFotoDepois'] == null ? null : nativeFromJson<String>(json['urlFotoDepois']),
  paciente = ListarRefeicoesPacienteRefeicaosPaciente.fromJson(json['paciente']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarRefeicoesPacienteRefeicaos otherTyped = other as ListarRefeicoesPacienteRefeicaos;
    return id == otherTyped.id && 
    dataHora == otherTyped.dataHora && 
    status == otherTyped.status && 
    urlFotoAntes == otherTyped.urlFotoAntes && 
    urlFotoDepois == otherTyped.urlFotoDepois && 
    paciente == otherTyped.paciente;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, dataHora.hashCode, status.hashCode, urlFotoAntes.hashCode, urlFotoDepois.hashCode, paciente.hashCode]);
  

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
    return json;
  }

  ListarRefeicoesPacienteRefeicaos({
    required this.id,
    required this.dataHora,
    required this.status,
    required this.urlFotoAntes,
    this.urlFotoDepois,
    required this.paciente,
  });
}

@immutable
class ListarRefeicoesPacienteRefeicaosPaciente {
  final String nome;
  ListarRefeicoesPacienteRefeicaosPaciente.fromJson(dynamic json):
  
  nome = nativeFromJson<String>(json['nome']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarRefeicoesPacienteRefeicaosPaciente otherTyped = other as ListarRefeicoesPacienteRefeicaosPaciente;
    return nome == otherTyped.nome;
    
  }
  @override
  int get hashCode => nome.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nome'] = nativeToJson<String>(nome);
    return json;
  }

  ListarRefeicoesPacienteRefeicaosPaciente({
    required this.nome,
  });
}

@immutable
class ListarRefeicoesPacienteData {
  final List<ListarRefeicoesPacienteRefeicaos> refeicaos;
  ListarRefeicoesPacienteData.fromJson(dynamic json):
  
  refeicaos = (json['refeicaos'] as List<dynamic>)
        .map((e) => ListarRefeicoesPacienteRefeicaos.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarRefeicoesPacienteData otherTyped = other as ListarRefeicoesPacienteData;
    return refeicaos == otherTyped.refeicaos;
    
  }
  @override
  int get hashCode => refeicaos.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['refeicaos'] = refeicaos.map((e) => e.toJson()).toList();
    return json;
  }

  ListarRefeicoesPacienteData({
    required this.refeicaos,
  });
}

@immutable
class ListarRefeicoesPacienteVariables {
  final String pacienteId;
  late final Optional<String>status;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListarRefeicoesPacienteVariables.fromJson(Map<String, dynamic> json):
  
  pacienteId = nativeFromJson<String>(json['pacienteId']) {
  
  
  
    status = Optional.optional(nativeFromJson, nativeToJson);
    status.value = json['status'] == null ? null : nativeFromJson<String>(json['status']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListarRefeicoesPacienteVariables otherTyped = other as ListarRefeicoesPacienteVariables;
    return pacienteId == otherTyped.pacienteId && 
    status == otherTyped.status;
    
  }
  @override
  int get hashCode => Object.hashAll([pacienteId.hashCode, status.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['pacienteId'] = nativeToJson<String>(pacienteId);
    if(status.state == OptionalState.set) {
      json['status'] = status.toJson();
    }
    return json;
  }

  ListarRefeicoesPacienteVariables({
    required this.pacienteId,
    required this.status,
  });
}

