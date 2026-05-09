import 'package:flutter/material.dart';
import 'package:project_appetit/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_appetit/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_appetit/dataconnect_generated/generated.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = true;
  String currentUserId = "";

  String userName = "Carregando...";
  String userEmail = "Carregando...";

  @override
  void initState() {
    super.initState();
    _carregarDadosUsuario();
  }

  Future<void> _carregarDadosUsuario() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final uid = prefs.getString('userId');

      if (uid != null) {
        currentUserId = uid;
        final connector = ExampleConnector.instance;

        final result = await connector.obterUsuarioPorId(id: uid).execute();

        if (result.data.usuario != null) {
          setState(() {
            userName = result.data.usuario!.nome;
            userEmail = result.data.usuario!.email;
            _isLoading = false;
          });
          return;
        }
      }
    } catch (e) {
      debugPrint("Erro ao carregar perfil: $e");
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _editarCampo(
    String titulo,
    String valorAtual,
    Function(String) onSalvar,
  ) async {
    TextEditingController controller = TextEditingController(
      text: titulo == "Senha" ? "" : valorAtual,
    );

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Editar $titulo"),
        content: TextField(
          controller: controller,
          obscureText: titulo == "Senha",
          decoration: InputDecoration(hintText: "Digite o novo $titulo"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              final novoValor = controller.text.trim();

              if (novoValor.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('O campo não pode estar vazio')),
                );
                return;
              }

              if (titulo == "Senha" && novoValor.length < 6) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('A senha deve ter pelo menos 6 caracteres'),
                  ),
                );
                return;
              }

              try {
                final user = FirebaseAuth.instance.currentUser;
                final connector = ExampleConnector.instance;

                if (titulo == "Nome") {
                  await connector
                      .atualizarPerfil(id: currentUserId)
                      .nome(novoValor)
                      .execute();
                } else if (titulo == "Email") {
                  if (user != null) {
                    await user.verifyBeforeUpdateEmail(novoValor.toLowerCase());
                  }
                  await connector
                      .atualizarPerfil(id: currentUserId)
                      .email(novoValor.toLowerCase())
                      .execute();
                } else if (titulo == "Senha") {
                  if (user != null) {
                    await user.updatePassword(novoValor);
                  }
                  await connector
                      .atualizarSenha(
                        id: currentUserId,
                        senhaHashNova: novoValor,
                      )
                      .execute();
                }

                setState(() {
                  onSalvar(
                    titulo == "Email" ? novoValor.toLowerCase() : novoValor,
                  );
                });

                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Atualizado com sucesso!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } on FirebaseAuthException catch (e) {
                String mensagem = 'Erro ao atualizar';
                if (e.code == 'email-already-in-use') {
                  mensagem = 'Este e-mail já está em uso';
                } else if (e.code == 'weak-password') {
                  mensagem = 'A senha é muito fraca';
                } else if (e.code == 'invalid-email') {
                  mensagem = 'E-mail inválido';
                } else if (e.code == 'requires-recent-login') {
                  mensagem =
                      'Faça login novamente para alterar dados sensíveis';
                }

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(mensagem),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro inesperado: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Perfil do Responsável",
          style: TextStyle(
            color: AppConstants.textBlack,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppConstants.primaryOrange,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                children: [
                  _buildProfileCard(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.transparent,
                          child: SvgPicture.asset(
                            'assets/icons/user-img.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  userName,
                                  style: AppConstants.cardTitleStyle.copyWith(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () => _editarCampo(
                                "Nome",
                                userName,
                                (novo) => userName = novo,
                              ),
                              child: const Icon(
                                Icons.edit_outlined,
                                size: 18,
                                color: AppConstants.textBlack,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppConstants.elementSpacing),
                  _buildInfoTile(
                    icon: Icons.email_outlined,
                    label: "Email",
                    value: userEmail,
                    onEdit: () => _editarCampo(
                      "Email",
                      userEmail,
                      (novo) => userEmail = novo,
                    ),
                  ),
                  _buildInfoTile(
                    icon: Icons.lock_outline,
                    label: "Senha",
                    value: "",
                    onEdit: () => _editarCampo("Senha", "", (novo) {}),
                  ),
                  _buildInfoTile(
                    icon: Icons.logout,
                    label: "Sair",
                    value: "",
                    isLogout: true,
                    onEdit: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                      await FirebaseAuth.instance.signOut();
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.cardPadding),
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppConstants.borderOrange.withOpacity(0.3),
          width: 1.2,
        ),
      ),
      child: child,
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onEdit,
    bool isLogout = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: isLogout ? onEdit : null,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppConstants.backgroundColor,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: AppConstants.primaryOrange.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppConstants.primaryOrange.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.textBlack,
                      ),
                    ),
                    if (value.isNotEmpty)
                      FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          value,
                          maxLines: 1,
                          style: const TextStyle(
                            color: AppConstants.textGrey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (!isLogout)
                IconButton(
                  icon: const Icon(
                    Icons.edit_outlined,
                    size: 22,
                    color: AppConstants.textBlack,
                  ),
                  onPressed: onEdit,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
