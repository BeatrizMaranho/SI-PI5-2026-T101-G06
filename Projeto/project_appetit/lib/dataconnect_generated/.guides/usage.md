# Basic Usage

```dart
ExampleConnector.instance.CriarUsuario(criarUsuarioVariables).execute();
ExampleConnector.instance.AtualizarPerfil(atualizarPerfilVariables).execute();
ExampleConnector.instance.AtualizarSenha(atualizarSenhaVariables).execute();
ExampleConnector.instance.CriarPaciente(criarPacienteVariables).execute();
ExampleConnector.instance.AtualizarPaciente(atualizarPacienteVariables).execute();
ExampleConnector.instance.DeletarPaciente(deletarPacienteVariables).execute();
ExampleConnector.instance.VincularNutricionista(vincularNutricionistaVariables).execute();
ExampleConnector.instance.DesvincularNutricionista(desvincularNutricionistaVariables).execute();
ExampleConnector.instance.VincularNutricionistaComPaciente(vincularNutricionistaComPacienteVariables).execute();
ExampleConnector.instance.CriarRefeicao(criarRefeicaoVariables).execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await ExampleConnector.instance.ListarRelatorioPaciente({ ... })
.limite(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

