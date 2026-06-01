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

## Mutations

### CriarUsuario
#### Required Arguments
```dart
String id = ...;
String nome = ...;
String email = ...;
String senhaHash = ...;
String tipo = ...;
ExampleConnector.instance.criarUsuario(
  id: id,
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
  id: id,
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
String id = ...;
String nome = ...;
String email = ...;
String senhaHash = ...;
String tipo = ...;

final ref = ExampleConnector.instance.criarUsuario(
  id: id,
  nome: nome,
  email: email,
  senhaHash: senhaHash,
  tipo: tipo,
).ref();
ref.execute();
```


### DeletarUsuario
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.deletarUsuario(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeletarUsuarioData, DeletarUsuarioVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deletarUsuario(
  id: id,
);
DeletarUsuarioData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.deletarUsuario(
  id: id,
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
  CriarPacienteVariablesBuilder peso(double? t) {
   _peso.value = t;
   return this;
  }
  CriarPacienteVariablesBuilder alergias(String? t) {
   _alergias.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.criarPaciente(
  nome: nome,
  responsavelId: responsavelId,
)
.nascimento(nascimento)
.peso(peso)
.alergias(alergias)
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
  AtualizarPacienteVariablesBuilder peso(double? t) {
   _peso.value = t;
   return this;
  }
  AtualizarPacienteVariablesBuilder alergias(String? t) {
   _alergias.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.atualizarPaciente(
  id: id,
)
.nome(nome)
.nascimento(nascimento)
.peso(peso)
.alergias(alergias)
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


### CriarRefeicao
#### Required Arguments
```dart
String pacienteId = ...;
String status = ...;
String urlFotoAntes = ...;
String urlFotoDepois = ...;
ExampleConnector.instance.criarRefeicao(
  pacienteId: pacienteId,
  status: status,
  urlFotoAntes: urlFotoAntes,
  urlFotoDepois: urlFotoDepois,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CriarRefeicao, we created `CriarRefeicaoBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CriarRefeicaoVariablesBuilder {
  ...
   CriarRefeicaoVariablesBuilder analise(String? t) {
   _analise.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.criarRefeicao(
  pacienteId: pacienteId,
  status: status,
  urlFotoAntes: urlFotoAntes,
  urlFotoDepois: urlFotoDepois,
)
.analise(analise)
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
  status: status,
  urlFotoAntes: urlFotoAntes,
  urlFotoDepois: urlFotoDepois,
);
CriarRefeicaoData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String pacienteId = ...;
String status = ...;
String urlFotoAntes = ...;
String urlFotoDepois = ...;

final ref = ExampleConnector.instance.criarRefeicao(
  pacienteId: pacienteId,
  status: status,
  urlFotoAntes: urlFotoAntes,
  urlFotoDepois: urlFotoDepois,
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

