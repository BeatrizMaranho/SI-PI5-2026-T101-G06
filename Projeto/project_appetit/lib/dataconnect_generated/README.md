# dataconnect_generated SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
ExampleConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### ObterUsuarioAtual
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.obterUsuarioAtual(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ObterUsuarioAtualData, ObterUsuarioAtualVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.obterUsuarioAtual(
  id: id,
);
ObterUsuarioAtualData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.obterUsuarioAtual(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### BuscarUsuarioPorEmail
#### Required Arguments
```dart
String email = ...;
ExampleConnector.instance.buscarUsuarioPorEmail(
  email: email,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<BuscarUsuarioPorEmailData, BuscarUsuarioPorEmailVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.buscarUsuarioPorEmail(
  email: email,
);
BuscarUsuarioPorEmailData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String email = ...;

final ref = ExampleConnector.instance.buscarUsuarioPorEmail(
  email: email,
).ref();
ref.execute();

ref.subscribe(...);
```


### ObterUsuarioPorId
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.obterUsuarioPorId(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ObterUsuarioPorIdData, ObterUsuarioPorIdVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.obterUsuarioPorId(
  id: id,
);
ObterUsuarioPorIdData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.obterUsuarioPorId(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListarMeusPacientes
#### Required Arguments
```dart
String responsavelId = ...;
ExampleConnector.instance.listarMeusPacientes(
  responsavelId: responsavelId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListarMeusPacientesData, ListarMeusPacientesVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listarMeusPacientes(
  responsavelId: responsavelId,
);
ListarMeusPacientesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String responsavelId = ...;

final ref = ExampleConnector.instance.listarMeusPacientes(
  responsavelId: responsavelId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ObterPacienteComRefeicoes
#### Required Arguments
```dart
String pacienteId = ...;
ExampleConnector.instance.obterPacienteComRefeicoes(
  pacienteId: pacienteId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ObterPacienteComRefeicoesData, ObterPacienteComRefeicoesVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.obterPacienteComRefeicoes(
  pacienteId: pacienteId,
);
ObterPacienteComRefeicoesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String pacienteId = ...;

final ref = ExampleConnector.instance.obterPacienteComRefeicoes(
  pacienteId: pacienteId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ObterPacienteCompleto
#### Required Arguments
```dart
String pacienteId = ...;
ExampleConnector.instance.obterPacienteCompleto(
  pacienteId: pacienteId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ObterPacienteCompletoData, ObterPacienteCompletoVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.obterPacienteCompleto(
  pacienteId: pacienteId,
);
ObterPacienteCompletoData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String pacienteId = ...;

final ref = ExampleConnector.instance.obterPacienteCompleto(
  pacienteId: pacienteId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListarPacientesVinculados
#### Required Arguments
```dart
String nutricionistaId = ...;
ExampleConnector.instance.listarPacientesVinculados(
  nutricionistaId: nutricionistaId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListarPacientesVinculadosData, ListarPacientesVinculadosVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listarPacientesVinculados(
  nutricionistaId: nutricionistaId,
);
ListarPacientesVinculadosData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String nutricionistaId = ...;

final ref = ExampleConnector.instance.listarPacientesVinculados(
  nutricionistaId: nutricionistaId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ObterPacienteParaNutricionista
#### Required Arguments
```dart
String pacienteId = ...;
ExampleConnector.instance.obterPacienteParaNutricionista(
  pacienteId: pacienteId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ObterPacienteParaNutricionistaData, ObterPacienteParaNutricionistaVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.obterPacienteParaNutricionista(
  pacienteId: pacienteId,
);
ObterPacienteParaNutricionistaData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String pacienteId = ...;

final ref = ExampleConnector.instance.obterPacienteParaNutricionista(
  pacienteId: pacienteId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListarRefeicoesPaciente
#### Required Arguments
```dart
String pacienteId = ...;
ExampleConnector.instance.listarRefeicoesPaciente(
  pacienteId: pacienteId,
).execute();
```

#### Optional Arguments
We return a builder for each query. For ListarRefeicoesPaciente, we created `ListarRefeicoesPacienteBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListarRefeicoesPacienteVariablesBuilder {
  ...
   ListarRefeicoesPacienteVariablesBuilder status(String? t) {
   _status.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.listarRefeicoesPaciente(
  pacienteId: pacienteId,
)
.status(status)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListarRefeicoesPacienteData, ListarRefeicoesPacienteVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listarRefeicoesPaciente(
  pacienteId: pacienteId,
);
ListarRefeicoesPacienteData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String pacienteId = ...;

final ref = ExampleConnector.instance.listarRefeicoesPaciente(
  pacienteId: pacienteId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ObterRefeicaoComDeteccoes
#### Required Arguments
```dart
String refeicaoId = ...;
ExampleConnector.instance.obterRefeicaoComDeteccoes(
  refeicaoId: refeicaoId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ObterRefeicaoComDeteccoesData, ObterRefeicaoComDeteccoesVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.obterRefeicaoComDeteccoes(
  refeicaoId: refeicaoId,
);
ObterRefeicaoComDeteccoesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String refeicaoId = ...;

final ref = ExampleConnector.instance.obterRefeicaoComDeteccoes(
  refeicaoId: refeicaoId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListarRefeicoesPendentes
#### Required Arguments
```dart
String pacienteId = ...;
ExampleConnector.instance.listarRefeicoesPendentes(
  pacienteId: pacienteId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListarRefeicoesPendentesData, ListarRefeicoesPendentesVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listarRefeicoesPendentes(
  pacienteId: pacienteId,
);
ListarRefeicoesPendentesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String pacienteId = ...;

final ref = ExampleConnector.instance.listarRefeicoesPendentes(
  pacienteId: pacienteId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListarDeteccoesPorRefeicao
#### Required Arguments
```dart
String refeicaoId = ...;
ExampleConnector.instance.listarDeteccoesPorRefeicao(
  refeicaoId: refeicaoId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListarDeteccoesPorRefeicaoData, ListarDeteccoesPorRefeicaoVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listarDeteccoesPorRefeicao(
  refeicaoId: refeicaoId,
);
ListarDeteccoesPorRefeicaoData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String refeicaoId = ...;

final ref = ExampleConnector.instance.listarDeteccoesPorRefeicao(
  refeicaoId: refeicaoId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListarDeteccoesAceitasPorRefeicao
#### Required Arguments
```dart
String refeicaoId = ...;
ExampleConnector.instance.listarDeteccoesAceitasPorRefeicao(
  refeicaoId: refeicaoId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListarDeteccoesAceitasPorRefeicaoData, ListarDeteccoesAceitasPorRefeicaoVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listarDeteccoesAceitasPorRefeicao(
  refeicaoId: refeicaoId,
);
ListarDeteccoesAceitasPorRefeicaoData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String refeicaoId = ...;

final ref = ExampleConnector.instance.listarDeteccoesAceitasPorRefeicao(
  refeicaoId: refeicaoId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ObterRelatorioPorRefeicao
#### Required Arguments
```dart
String refeicaoId = ...;
ExampleConnector.instance.obterRelatorioPorRefeicao(
  refeicaoId: refeicaoId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ObterRelatorioPorRefeicaoData, ObterRelatorioPorRefeicaoVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.obterRelatorioPorRefeicao(
  refeicaoId: refeicaoId,
);
ObterRelatorioPorRefeicaoData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String refeicaoId = ...;

final ref = ExampleConnector.instance.obterRelatorioPorRefeicao(
  refeicaoId: refeicaoId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListarRelatorioPaciente
#### Required Arguments
```dart
String pacienteId = ...;
ExampleConnector.instance.listarRelatorioPaciente(
  pacienteId: pacienteId,
).execute();
```

#### Optional Arguments
We return a builder for each query. For ListarRelatorioPaciente, we created `ListarRelatorioPacienteBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListarRelatorioPacienteVariablesBuilder {
  ...
   ListarRelatorioPacienteVariablesBuilder limite(int? t) {
   _limite.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.listarRelatorioPaciente(
  pacienteId: pacienteId,
)
.limite(limite)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListarRelatorioPacienteData, ListarRelatorioPacienteVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listarRelatorioPaciente(
  pacienteId: pacienteId,
);
ListarRelatorioPacienteData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String pacienteId = ...;

final ref = ExampleConnector.instance.listarRelatorioPaciente(
  pacienteId: pacienteId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ObterRelatorioCompleto
#### Required Arguments
```dart
String relatorioId = ...;
ExampleConnector.instance.obterRelatorioCompleto(
  relatorioId: relatorioId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ObterRelatorioCompletoData, ObterRelatorioCompletoVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.obterRelatorioCompleto(
  relatorioId: relatorioId,
);
ObterRelatorioCompletoData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String relatorioId = ...;

final ref = ExampleConnector.instance.obterRelatorioCompleto(
  relatorioId: relatorioId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListarCatalogoAlimentos
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listarCatalogoAlimentos().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListarCatalogoAlimentosData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listarCatalogoAlimentos();
ListarCatalogoAlimentosData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listarCatalogoAlimentos().ref();
ref.execute();

ref.subscribe(...);
```


### BuscarAlimentoPorLabel
#### Required Arguments
```dart
String label = ...;
ExampleConnector.instance.buscarAlimentoPorLabel(
  label: label,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<BuscarAlimentoPorLabelData, BuscarAlimentoPorLabelVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.buscarAlimentoPorLabel(
  label: label,
);
BuscarAlimentoPorLabelData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String label = ...;

final ref = ExampleConnector.instance.buscarAlimentoPorLabel(
  label: label,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListarAlimentosPorCategoria
#### Required Arguments
```dart
String categoria = ...;
ExampleConnector.instance.listarAlimentosPorCategoria(
  categoria: categoria,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListarAlimentosPorCategoriaData, ListarAlimentosPorCategoriaVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listarAlimentosPorCategoria(
  categoria: categoria,
);
ListarAlimentosPorCategoriaData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String categoria = ...;

final ref = ExampleConnector.instance.listarAlimentosPorCategoria(
  categoria: categoria,
).ref();
ref.execute();

ref.subscribe(...);
```


### ResumoRefeicoes7Dias
#### Required Arguments
```dart
String pacienteId = ...;
Timestamp dataLimite = ...;
ExampleConnector.instance.resumoRefeicoes7Dias(
  pacienteId: pacienteId,
  dataLimite: dataLimite,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ResumoRefeicoes7DiasData, ResumoRefeicoes7DiasVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.resumoRefeicoes7Dias(
  pacienteId: pacienteId,
  dataLimite: dataLimite,
);
ResumoRefeicoes7DiasData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String pacienteId = ...;
Timestamp dataLimite = ...;

final ref = ExampleConnector.instance.resumoRefeicoes7Dias(
  pacienteId: pacienteId,
  dataLimite: dataLimite,
).ref();
ref.execute();

ref.subscribe(...);
```


### AlimentosMaisDetectados
#### Required Arguments
```dart
String pacienteId = ...;
Timestamp dataLimite = ...;
ExampleConnector.instance.alimentosMaisDetectados(
  pacienteId: pacienteId,
  dataLimite: dataLimite,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<AlimentosMaisDetectadosData, AlimentosMaisDetectadosVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.alimentosMaisDetectados(
  pacienteId: pacienteId,
  dataLimite: dataLimite,
);
AlimentosMaisDetectadosData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String pacienteId = ...;
Timestamp dataLimite = ...;

final ref = ExampleConnector.instance.alimentosMaisDetectados(
  pacienteId: pacienteId,
  dataLimite: dataLimite,
).ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### CriarUsuario
#### Required Arguments
```dart
String nome = ...;
String email = ...;
String senhaHash = ...;
String tipo = ...;
ExampleConnector.instance.criarUsuario(
  nome: nome,
  email: email,
  senhaHash: senhaHash,
  tipo: tipo,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CriarUsuarioData, CriarUsuarioVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.criarUsuario(
  nome: nome,
  email: email,
  senhaHash: senhaHash,
  tipo: tipo,
);
CriarUsuarioData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String nome = ...;
String email = ...;
String senhaHash = ...;
String tipo = ...;

final ref = ExampleConnector.instance.criarUsuario(
  nome: nome,
  email: email,
  senhaHash: senhaHash,
  tipo: tipo,
).ref();
ref.execute();
```


### AtualizarPerfil
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.atualizarPerfil(
  id: id,
).execute();
```

#### Optional Arguments
We return a builder for each query. For AtualizarPerfil, we created `AtualizarPerfilBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class AtualizarPerfilVariablesBuilder {
  ...
   AtualizarPerfilVariablesBuilder nome(String? t) {
   _nome.value = t;
   return this;
  }
  AtualizarPerfilVariablesBuilder email(String? t) {
   _email.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.atualizarPerfil(
  id: id,
)
.nome(nome)
.email(email)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<AtualizarPerfilData, AtualizarPerfilVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.atualizarPerfil(
  id: id,
);
AtualizarPerfilData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.atualizarPerfil(
  id: id,
).ref();
ref.execute();
```


### AtualizarSenha
#### Required Arguments
```dart
String id = ...;
String senhaHashNova = ...;
ExampleConnector.instance.atualizarSenha(
  id: id,
  senhaHashNova: senhaHashNova,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<AtualizarSenhaData, AtualizarSenhaVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.atualizarSenha(
  id: id,
  senhaHashNova: senhaHashNova,
);
AtualizarSenhaData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
String senhaHashNova = ...;

final ref = ExampleConnector.instance.atualizarSenha(
  id: id,
  senhaHashNova: senhaHashNova,
).ref();
ref.execute();
```


### CriarPaciente
#### Required Arguments
```dart
String nome = ...;
String responsavelId = ...;
ExampleConnector.instance.criarPaciente(
  nome: nome,
  responsavelId: responsavelId,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CriarPaciente, we created `CriarPacienteBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CriarPacienteVariablesBuilder {
  ...
   CriarPacienteVariablesBuilder nascimento(DateTime? t) {
   _nascimento.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.criarPaciente(
  nome: nome,
  responsavelId: responsavelId,
)
.nascimento(nascimento)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CriarPacienteData, CriarPacienteVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.criarPaciente(
  nome: nome,
  responsavelId: responsavelId,
);
CriarPacienteData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String nome = ...;
String responsavelId = ...;

final ref = ExampleConnector.instance.criarPaciente(
  nome: nome,
  responsavelId: responsavelId,
).ref();
ref.execute();
```


### AtualizarPaciente
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.atualizarPaciente(
  id: id,
).execute();
```

#### Optional Arguments
We return a builder for each query. For AtualizarPaciente, we created `AtualizarPacienteBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class AtualizarPacienteVariablesBuilder {
  ...
   AtualizarPacienteVariablesBuilder nome(String? t) {
   _nome.value = t;
   return this;
  }
  AtualizarPacienteVariablesBuilder nascimento(DateTime? t) {
   _nascimento.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.atualizarPaciente(
  id: id,
)
.nome(nome)
.nascimento(nascimento)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<AtualizarPacienteData, AtualizarPacienteVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.atualizarPaciente(
  id: id,
);
AtualizarPacienteData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.atualizarPaciente(
  id: id,
).ref();
ref.execute();
```


### DeletarPaciente
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.deletarPaciente(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeletarPacienteData, DeletarPacienteVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deletarPaciente(
  id: id,
);
DeletarPacienteData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.deletarPaciente(
  id: id,
).ref();
ref.execute();
```


### VincularNutricionista
#### Required Arguments
```dart
String nutricionistaId = ...;
String pacienteId = ...;
ExampleConnector.instance.vincularNutricionista(
  nutricionistaId: nutricionistaId,
  pacienteId: pacienteId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<VincularNutricionistaData, VincularNutricionistaVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.vincularNutricionista(
  nutricionistaId: nutricionistaId,
  pacienteId: pacienteId,
);
VincularNutricionistaData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String nutricionistaId = ...;
String pacienteId = ...;

final ref = ExampleConnector.instance.vincularNutricionista(
  nutricionistaId: nutricionistaId,
  pacienteId: pacienteId,
).ref();
ref.execute();
```


### DesvincularNutricionista
#### Required Arguments
```dart
String nutricionistaId = ...;
String pacienteId = ...;
ExampleConnector.instance.desvincularNutricionista(
  nutricionistaId: nutricionistaId,
  pacienteId: pacienteId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DesvincularNutricionistaData, DesvincularNutricionistaVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.desvincularNutricionista(
  nutricionistaId: nutricionistaId,
  pacienteId: pacienteId,
);
DesvincularNutricionistaData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String nutricionistaId = ...;
String pacienteId = ...;

final ref = ExampleConnector.instance.desvincularNutricionista(
  nutricionistaId: nutricionistaId,
  pacienteId: pacienteId,
).ref();
ref.execute();
```


### VincularNutricionistaComPaciente
#### Required Arguments
```dart
String nutricionistaId = ...;
String pacienteId = ...;
ExampleConnector.instance.vincularNutricionistaComPaciente(
  nutricionistaId: nutricionistaId,
  pacienteId: pacienteId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<VincularNutricionistaComPacienteData, VincularNutricionistaComPacienteVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.vincularNutricionistaComPaciente(
  nutricionistaId: nutricionistaId,
  pacienteId: pacienteId,
);
VincularNutricionistaComPacienteData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String nutricionistaId = ...;
String pacienteId = ...;

final ref = ExampleConnector.instance.vincularNutricionistaComPaciente(
  nutricionistaId: nutricionistaId,
  pacienteId: pacienteId,
).ref();
ref.execute();
```


### CriarRefeicao
#### Required Arguments
```dart
String pacienteId = ...;
String urlFotoAntes = ...;
ExampleConnector.instance.criarRefeicao(
  pacienteId: pacienteId,
  urlFotoAntes: urlFotoAntes,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CriarRefeicao, we created `CriarRefeicaoBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CriarRefeicaoVariablesBuilder {
  ...
   CriarRefeicaoVariablesBuilder status(String? t) {
   _status.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.criarRefeicao(
  pacienteId: pacienteId,
  urlFotoAntes: urlFotoAntes,
)
.status(status)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CriarRefeicaoData, CriarRefeicaoVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.criarRefeicao(
  pacienteId: pacienteId,
  urlFotoAntes: urlFotoAntes,
);
CriarRefeicaoData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String pacienteId = ...;
String urlFotoAntes = ...;

final ref = ExampleConnector.instance.criarRefeicao(
  pacienteId: pacienteId,
  urlFotoAntes: urlFotoAntes,
).ref();
ref.execute();
```


### AtualizarRefeicao
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.atualizarRefeicao(
  id: id,
).execute();
```

#### Optional Arguments
We return a builder for each query. For AtualizarRefeicao, we created `AtualizarRefeicaoBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class AtualizarRefeicaoVariablesBuilder {
  ...
   AtualizarRefeicaoVariablesBuilder urlFotoDepois(String? t) {
   _urlFotoDepois.value = t;
   return this;
  }
  AtualizarRefeicaoVariablesBuilder status(String? t) {
   _status.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.atualizarRefeicao(
  id: id,
)
.urlFotoDepois(urlFotoDepois)
.status(status)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<AtualizarRefeicaoData, AtualizarRefeicaoVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.atualizarRefeicao(
  id: id,
);
AtualizarRefeicaoData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.atualizarRefeicao(
  id: id,
).ref();
ref.execute();
```


### DeletarRefeicao
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.deletarRefeicao(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeletarRefeicaoData, DeletarRefeicaoVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deletarRefeicao(
  id: id,
);
DeletarRefeicaoData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.deletarRefeicao(
  id: id,
).ref();
ref.execute();
```


### MarcarRefeicaoAnalisada
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.marcarRefeicaoAnalisada(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<MarcarRefeicaoAnalisadaData, MarcarRefeicaoAnalisadaVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.marcarRefeicaoAnalisada(
  id: id,
);
MarcarRefeicaoAnalisadaData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.marcarRefeicaoAnalisada(
  id: id,
).ref();
ref.execute();
```


### RejeitarRefeicao
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.rejeitarRefeicao(
  id: id,
).execute();
```

#### Optional Arguments
We return a builder for each query. For RejeitarRefeicao, we created `RejeitarRefeicaoBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class RejeitarRefeicaoVariablesBuilder {
  ...
   RejeitarRefeicaoVariablesBuilder motivo(String? t) {
   _motivo.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.rejeitarRefeicao(
  id: id,
)
.motivo(motivo)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<RejeitarRefeicaoData, RejeitarRefeicaoVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.rejeitarRefeicao(
  id: id,
);
RejeitarRefeicaoData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.rejeitarRefeicao(
  id: id,
).ref();
ref.execute();
```


### CriarDeteccao
#### Required Arguments
```dart
String refeicaoId = ...;
String alimentoId = ...;
double confidence = ...;
double percentualConsumido = ...;
ExampleConnector.instance.criarDeteccao(
  refeicaoId: refeicaoId,
  alimentoId: alimentoId,
  confidence: confidence,
  percentualConsumido: percentualConsumido,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CriarDeteccao, we created `CriarDeteccaoBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CriarDeteccaoVariablesBuilder {
  ...
   CriarDeteccaoVariablesBuilder cor(String? t) {
   _cor.value = t;
   return this;
  }
  CriarDeteccaoVariablesBuilder textura(String? t) {
   _textura.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.criarDeteccao(
  refeicaoId: refeicaoId,
  alimentoId: alimentoId,
  confidence: confidence,
  percentualConsumido: percentualConsumido,
)
.cor(cor)
.textura(textura)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CriarDeteccaoData, CriarDeteccaoVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.criarDeteccao(
  refeicaoId: refeicaoId,
  alimentoId: alimentoId,
  confidence: confidence,
  percentualConsumido: percentualConsumido,
);
CriarDeteccaoData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String refeicaoId = ...;
String alimentoId = ...;
double confidence = ...;
double percentualConsumido = ...;

final ref = ExampleConnector.instance.criarDeteccao(
  refeicaoId: refeicaoId,
  alimentoId: alimentoId,
  confidence: confidence,
  percentualConsumido: percentualConsumido,
).ref();
ref.execute();
```


### AtualizarDeteccao
#### Required Arguments
```dart
String id = ...;
bool aceito = ...;
ExampleConnector.instance.atualizarDeteccao(
  id: id,
  aceito: aceito,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<AtualizarDeteccaoData, AtualizarDeteccaoVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.atualizarDeteccao(
  id: id,
  aceito: aceito,
);
AtualizarDeteccaoData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
bool aceito = ...;

final ref = ExampleConnector.instance.atualizarDeteccao(
  id: id,
  aceito: aceito,
).ref();
ref.execute();
```


### DeletarDeteccao
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.deletarDeteccao(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeletarDeteccaoData, DeletarDeteccaoVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deletarDeteccao(
  id: id,
);
DeletarDeteccaoData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.deletarDeteccao(
  id: id,
).ref();
ref.execute();
```


### CriarAlimento
#### Required Arguments
```dart
String label = ...;
ExampleConnector.instance.criarAlimento(
  label: label,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CriarAlimento, we created `CriarAlimentoBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CriarAlimentoVariablesBuilder {
  ...
   CriarAlimentoVariablesBuilder categoria(String? t) {
   _categoria.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.criarAlimento(
  label: label,
)
.categoria(categoria)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CriarAlimentoData, CriarAlimentoVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.criarAlimento(
  label: label,
);
CriarAlimentoData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String label = ...;

final ref = ExampleConnector.instance.criarAlimento(
  label: label,
).ref();
ref.execute();
```


### AtualizarAlimento
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.atualizarAlimento(
  id: id,
).execute();
```

#### Optional Arguments
We return a builder for each query. For AtualizarAlimento, we created `AtualizarAlimentoBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class AtualizarAlimentoVariablesBuilder {
  ...
   AtualizarAlimentoVariablesBuilder label(String? t) {
   _label.value = t;
   return this;
  }
  AtualizarAlimentoVariablesBuilder categoria(String? t) {
   _categoria.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.atualizarAlimento(
  id: id,
)
.label(label)
.categoria(categoria)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<AtualizarAlimentoData, AtualizarAlimentoVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.atualizarAlimento(
  id: id,
);
AtualizarAlimentoData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.atualizarAlimento(
  id: id,
).ref();
ref.execute();
```


### DeletarAlimento
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.deletarAlimento(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeletarAlimentoData, DeletarAlimentoVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deletarAlimento(
  id: id,
);
DeletarAlimentoData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.deletarAlimento(
  id: id,
).ref();
ref.execute();
```


### CriarRelatorio
#### Required Arguments
```dart
String refeicaoId = ...;
String pacienteId = ...;
String conteudo = ...;
ExampleConnector.instance.criarRelatorio(
  refeicaoId: refeicaoId,
  pacienteId: pacienteId,
  conteudo: conteudo,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CriarRelatorioData, CriarRelatorioVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.criarRelatorio(
  refeicaoId: refeicaoId,
  pacienteId: pacienteId,
  conteudo: conteudo,
);
CriarRelatorioData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String refeicaoId = ...;
String pacienteId = ...;
String conteudo = ...;

final ref = ExampleConnector.instance.criarRelatorio(
  refeicaoId: refeicaoId,
  pacienteId: pacienteId,
  conteudo: conteudo,
).ref();
ref.execute();
```


### AtualizarRelatorio
#### Required Arguments
```dart
String id = ...;
String conteudo = ...;
ExampleConnector.instance.atualizarRelatorio(
  id: id,
  conteudo: conteudo,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<AtualizarRelatorioData, AtualizarRelatorioVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.atualizarRelatorio(
  id: id,
  conteudo: conteudo,
);
AtualizarRelatorioData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
String conteudo = ...;

final ref = ExampleConnector.instance.atualizarRelatorio(
  id: id,
  conteudo: conteudo,
).ref();
ref.execute();
```


### DeletarRelatorio
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.deletarRelatorio(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeletarRelatorioData, DeletarRelatorioVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deletarRelatorio(
  id: id,
);
DeletarRelatorioData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.deletarRelatorio(
  id: id,
).ref();
ref.execute();
```

