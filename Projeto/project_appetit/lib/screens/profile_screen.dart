import 'package:flutter/material.dart';
import 'package:project_appetit/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_appetit/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String userName = "Maria Silva";
    final String userRole = "Mãe";
    final String userEmail = "mariasilva@gmail.com";
    final String userPhone = "(00)0000-0000";

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor, // 0xFFFFF8F5
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true, // Centralizado conforme o padrão das outras telas
        title: const Text(
          "Perfil do Responsável",
          style: TextStyle(
            color: AppConstants.textBlack,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
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
                  Text(
                    userName,
                    style: AppConstants.cardTitleStyle.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userRole,
                        style: const TextStyle(
                          color: AppConstants.textGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.edit_outlined,
                        size: 18,
                        color: AppConstants.textBlack,
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
              value: "****",
              onEdit: () {},
            ),

            _buildInfoTile(
              icon: Icons.logout,
              label: "Sair",
              value: "",
              isLogout: true,
              onEdit: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
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
    // Cor sólida para o círculo padronizada (0xFFF67B55)
    const Color orangeColor = Color(0xFFF67B55);

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
                      Text(
                        value,
                        style: const TextStyle(
                          color: AppConstants.textGrey,
                          fontSize: 14,
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
