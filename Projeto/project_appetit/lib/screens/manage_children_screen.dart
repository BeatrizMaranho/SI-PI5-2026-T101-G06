import 'package:flutter/material.dart';
import 'package:project_appetit/constants.dart';
// ADICIONADO: Importação para usar SVGs
import 'package:flutter_svg/flutter_svg.dart';
import 'child_registration_screen.dart';

class ManageChildrenScreen extends StatelessWidget {
  const ManageChildrenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Cor para estatísticas: Refeições/Desde (0xFFF67B55)
    const Color statsOrange = Color(0xFFF67B55);
    
    // Cor para botões de ação: Câmera/Editar/Excluir/Adicionar (0xFFE35D33)
    const Color primaryOrange = Color(0xFFE35D33);

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor, // 0xFFFFF8F5
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Gerenciar crianças',
              style: AppConstants.titleStyle,
            ),
            const SizedBox(height: 20),
            const Text(
              'Crianças cadastradas',
              style: AppConstants.sectionStyle,
            ),
            const SizedBox(height: 20),
            
            // Passamos as duas cores para os cards
            childCard(context, "Sofia", "5 anos", "12", "00/00/0000", statsOrange, primaryOrange),
            const SizedBox(height: AppConstants.elementSpacing),
            childCard(context, "Arthur", "7 anos", "10", "00/00/0000", statsOrange, primaryOrange),
            
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChildRegistrationScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'Adicionar nova criança', 
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)
                ),
                style: ElevatedButton.styleFrom(
                  // AJUSTADO: Botão "Adicionar" com a cor 0xFFE35D33
                  backgroundColor: primaryOrange, 
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30), // Respiro no final da tela
          ],
        ),
      ),
    );
  }

  Widget childCard(
    BuildContext context, 
    String nome, 
    String idade, 
    String refeicoes, 
    String data, 
    Color statsColor, // Refeições/Desde
    Color actionColor // Câmera/Editar/Excluir
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.cardPadding),
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor, // Misturado com o fundo
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          // Borda mais clara com statsColor
          color: statsColor.withOpacity(0.3), 
          width: 1.2,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // ADICIONADO: CircleAvatar com o SVG user-img.svg
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent, // Transparente para o SVG
                child: SvgPicture.asset(
                  'assets/icons/user-img.svg', // Substitua pelo caminho correto do seu arquivo
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nome, style: AppConstants.cardTitleStyle),
                  Text(idade, style: const TextStyle(color: AppConstants.textGrey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              // MANTIDO: Estatísticas com a cor 0xFFF67B55
              expandedInfoBox("Refeições", refeicoes, Icons.restaurant, statsColor),
              const SizedBox(width: 10),
              expandedInfoBox("Desde", data, Icons.calendar_today, statsColor),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // AJUSTADO: Botões de ação com a cor 0xFFE35D33
              actionButton(Icons.camera_alt, actionColor),
              actionButton(Icons.edit, actionColor),
              actionButton(Icons.delete, actionColor),
            ],
          )
        ],
      ),
    );
  }

  Widget expandedInfoBox(String label, String value, IconData icon, Color statsColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: statsColor, // Cor 0xFFF67B55
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 14, color: Colors.white),
                const SizedBox(width: 5),
                Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              value, 
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)
            ),
          ],
        ),
      ),
    );
  }

  Widget actionButton(IconData icon, Color actionColor) {
    return Container(
      width: 80,
      height: 45,
      decoration: BoxDecoration(
        color: actionColor, // Cor 0xFFE35D33
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}