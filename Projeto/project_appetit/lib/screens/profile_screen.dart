import 'package:flutter/material.dart';
import 'package:project_appetit/constants.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Importe o pacote

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          style: AppConstants.sectionStyle,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            // --- Card de Perfil Principal (Avatar e Nome) ---
            _buildProfileCard(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.transparent,
                    child: SvgPicture.asset(
                      'assets/icons/user-img.svg',
                      fit: BoxFit.contain)
                      ,
                  ),
                  const SizedBox(height: 10),
                  Text(userName, style: AppConstants.cardTitleStyle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(userRole, style: AppConstants.sectionStyle.copyWith(
                        color: AppConstants.textGrey,
                        fontWeight: FontWeight.normal
                      )),
                      const SizedBox(width: 5),
                      const Icon(Icons.edit_outlined, size: 16, color: AppConstants.textBlack),
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
              onEdit: () { /* Lógica de edição */ },
            ),
            
            _buildInfoTile(
              icon: Icons.phone_outlined,
              label: "Telefone",
              value: userPhone,
              onEdit: () { /* Lógica de edição */ },
            ),
            
            _buildInfoTile(
              icon: Icons.lock_outline,
              label: "Senha",
              value: "********",
              onEdit: () { /* Lógica de edição */ },
            ),

            // --- Botão Sair ---
            _buildInfoTile(
              icon: Icons.logout,
              label: "Sair",
              value: "",
              isLogout: true,
              onEdit: () { /* Lógica de logout */ },
            ),
          ],
        ),
      ),
    );
  }

  // Helper para criar o container com borda laranja (Card padrão do print)
  Widget _buildProfileCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.cardPadding),
      decoration: BoxDecoration(
        color: AppConstants.cardWhite,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppConstants.primaryOrange.withOpacity(0.5), width: 1),
      ),
      child: child,
    );
  }

  // Widget para as linhas de informação (Email, Telefone, etc)
  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onEdit,
    bool isLogout = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.elementSpacing),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.cardPadding),
        decoration: BoxDecoration(
          color: AppConstants.cardWhite,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(color: AppConstants.primaryOrange.withOpacity(0.5), width: 1),
        ),
        child: Row(
          children: [
            // Ícone circular laranja
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppConstants.primaryOrange.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 15),
            // Textos
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppConstants.sectionStyle),
                  if (value.isNotEmpty)
                    Text(value, style: TextStyle(color: AppConstants.textGrey, fontSize: 14)),
                ],
              ),
            ),
            // Ícone de edição (não aparece no Sair)
            if (!isLogout)
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20, color: AppConstants.textBlack),
                onPressed: onEdit,
              ),
          ],
        ),
      ),
    );
  }
}