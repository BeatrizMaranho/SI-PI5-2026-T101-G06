import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Importe o arquivo gerado pelo seu Data Connect
import 'package:project_appetit/dataconnect_generated/generated.dart'; 

class HomeScreen extends StatelessWidget {
  final VoidCallback onNavigateToManageChildren;
  final VoidCallback onNavigateToProfile;

  const HomeScreen({
    super.key, 
    required this.onNavigateToManageChildren,
    required this.onNavigateToProfile,
  });

  // Cores baseadas no seu protótipo
  final Color primaryOrange = const Color(0xFFF27E53);
  final Color lightOrangeBorder = const Color(0xFFF5AC88);
  final Color backgroundColor = const Color(0xFFFCF8F5);

  // --- FUNÇÃO PARA BUSCAR AS CRIANÇAS NO BANCO ---
  Future<List<dynamic>> _buscarCriancasDoBanco() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return []; // Retorna vazio se não estiver logado

      // Chama a query existente no seu projeto passando o ID do usuário logado
      final response = await ExampleConnector.instance.listarMeusPacientes(responsavelId: user.uid).execute();
      
      return response.data.pacientes; 
    } catch (e) {
      debugPrint('Erro ao buscar crianças: $e');
      return [];
    }
  }

  // --- FUNÇÃO PARA CALCULAR A IDADE ---
  String _calcularIdade(String? dataNascimentoStr) {
    if (dataNascimentoStr == null || dataNascimentoStr.isEmpty) return 'Idade indisp.';
    
    try {
      // O banco retorna algo como "2020-04-29"
      DateTime dataNascimento = DateTime.parse(dataNascimentoStr);
      DateTime hoje = DateTime.now();
      
      int idade = hoje.year - dataNascimento.year;
      if (hoje.month < dataNascimento.month || 
         (hoje.month == dataNascimento.month && hoje.day < dataNascimento.day)) {
        idade--;
      }
      
      if (idade == 0) return 'Menos de 1 ano';
      if (idade == 1) return '1 ano';
      return '$idade anos';
    } catch (e) {
      return 'Idade indisp.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildWelcomeCard(),
              const SizedBox(height: 16),
              
              // --- BUSCA DINÂMICA NO BANCO ---
              FutureBuilder<List<dynamic>>(
                future: _buscarCriancasDoBanco(),
                builder: (context, snapshot) {
                  // Mostra loading enquanto busca
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: CircularProgressIndicator(color: primaryOrange),
                    );
                  }

                  // Tratamento de erro
                  if (snapshot.hasError) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("Erro ao carregar as crianças.", style: TextStyle(color: Colors.red)),
                    );
                  }

                  final criancas = snapshot.data ?? [];

                  // Se não tiver filhos cadastrados
                  if (criancas.isEmpty) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: lightOrangeBorder),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        children: [
                          Icon(Icons.child_care, size: 48, color: Colors.black26),
                          SizedBox(height: 12),
                          Text(
                            "Nenhuma criança cadastrada.\nAcesse 'Gerenciar crianças' para adicionar.",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    );
                  }

                  // Renderiza um card para cada criança que voltou do banco
                  return Column(
                    children: criancas.map((crianca) {
                      final nome = crianca.nome ?? 'Sem nome';
                      final idadeStr = _calcularIdade(crianca.nascimento?.toString());
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: _buildChildCard(nome, idadeStr),
                      );
                    }).toList(),
                  );
                },
              ),

              _buildManagementSection(),
            ],
          ),
        ),
      ),
    );
  }

  // --- FUNÇÕES DE CONSTRUÇÃO DOS COMPONENTES DA TELA ---

  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset(
          'assets/imgs/ovo.png', 
          height: 120,
        ),
        const SizedBox(height: 10),
        const Text(
          'APPETIT',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: lightOrangeBorder),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bem-vindo! 👋',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'Registre as refeições e acompanhe quais alimentos são aceitos ou rejeitados pelas crianças.',
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildChildCard(String name, String age) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: lightOrangeBorder),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
                child: Icon(Icons.account_circle_outlined, size: 48),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(age, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.camera_alt_outlined, color: Colors.white),
                  label: const Text('Foto', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryOrange,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.post_add, color: Colors.white),
                  label: const Text('Relatório', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryOrange,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildManagementSection() {
    return Row(
      children: [
        Expanded(
          child: _buildManagementButton(
            Icons.people_outline, 
            'Gerenciar crianças', 
            onTap: onNavigateToManageChildren,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildManagementButton(
            Icons.person_outline, 
            'Gerenciar perfil', 
            onTap: onNavigateToProfile, 
          ),
        ),
      ],
    );
  }

  Widget _buildManagementButton(IconData icon, String label, {required VoidCallback onTap}) {
    return _BouncingButton(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white, 
          border: Border.all(color: lightOrangeBorder),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: primaryOrange.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: primaryOrange,
              radius: 20,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// --- WIDGET DO EFEITO DE CLIQUE E MOUSE ---
class _BouncingButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _BouncingButton({required this.child, required this.onTap});

  @override
  State<_BouncingButton> createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<_BouncingButton> {
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.95 : (_isHovered ? 1.02 : 1.0),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          child: widget.child,
        ),
      ),
    );
  }
}