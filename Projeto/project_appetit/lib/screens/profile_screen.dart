import 'package:flutter/material.dart';
import 'package:project_appetit/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Retorna apenas o conteúdo da tela. 
    // O Scaffold com o menu e o botão de câmera já estarão em volta disso no MainLayout.
    return const Center(
      child: Text(
        "Bem-vindo ao Perfil",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),

    final String userName = "Maria Silva";
    final String userRole = "Mãe";
    final String userEmail = "mariasilva@gmail.com";
    final String userPhone = "(00)0000-0000";

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Perfil do Responsável",

          style: TextStyle(
            color: AppConstants.textBlack, 
            fontWeight: FontWeight.bold, 
            fontSize: 22
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
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
                  Text(userName, style: AppConstants.cardTitleStyle.copyWith(fontSize: 20)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(userRole, style: const TextStyle(
                        color: AppConstants.textGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.normal
                      )),
                      const SizedBox(width: 8),
                      const Icon(Icons.edit_outlined, size: 18, color: AppConstants.textBlack),
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
              onEdit: () {},
            ),
            
            _buildInfoTile(
              icon: Icons.phone_outlined,
              label: "Telefone",
              value: userPhone,
              onEdit: () {},
            ),
            
            _buildInfoTile(
              icon: Icons.lock_outline,
              label: "Senha",
              value: "********",
              onEdit: () {},
            ),

            _buildInfoTile(
              icon: Icons.logout,
              label: "Sair",
              value: "",
              isLogout: true,
              onEdit: () {},
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
          color: AppConstants.primaryOrange.withOpacity(0.3), 
          width: 1.5
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
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppConstants.backgroundColor, 
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: AppConstants.primaryOrange.withOpacity(0.3), 
            width: 1.5
          ),
        ),
        child: Row(
          children: [
            // AJUSTE AQUI: Laranja com opacidade para não ficar escuro
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppConstants.primaryOrange.withOpacity(0.8), // 0.7 para ser vivo mas não escuro
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon, 
                color: Colors.white, 
                size: 24
              ), 
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold, 
                    color: AppConstants.textBlack
                  )),
                  if (value.isNotEmpty)
                    Text(value, style: const TextStyle(
                      color: AppConstants.textGrey, 
                      fontSize: 14
                    )),
                ],
              ),
            ),
            if (!isLogout)
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 22, color: AppConstants.textBlack),
                onPressed: onEdit,
              ),
          ],
        ),
      ),
    );
  }
}