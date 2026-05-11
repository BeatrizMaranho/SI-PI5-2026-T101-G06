# Basic Usage

```dart
ExampleConnector.instance.ObterUsuarioAtual(obterUsuarioAtualVariables).execute();
ExampleConnector.instance.BuscarUsuarioPorEmail(buscarUsuarioPorEmailVariables).execute();
ExampleConnector.instance.ObterUsuarioPorId(obterUsuarioPorIdVariables).execute();
ExampleConnector.instance.ListarMeusPacientes(listarMeusPacientesVariables).execute();
ExampleConnector.instance.ObterPacienteComRefeicoes(obterPacienteComRefeicoesVariables).execute();
ExampleConnector.instance.ObterPacienteCompleto(obterPacienteCompletoVariables).execute();
ExampleConnector.instance.ListarPacientesVinculados(listarPacientesVinculadosVariables).execute();
ExampleConnector.instance.ObterPacienteParaNutricionista(obterPacienteParaNutricionistaVariables).execute();
ExampleConnector.instance.ListarRefeicoesPaciente(listarRefeicoesPacienteVariables).execute();
ExampleConnector.instance.ObterRefeicaoComDeteccoes(obterRefeicaoComDeteccoesVariables).execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await ExampleConnector.instance.AtualizarAlimento({ ... })
.label(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

