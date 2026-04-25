import 'package:flutter/material.dart';
import 'package:project_appetit/constants.dart';
import 'child_registration_screen.dart';
class ManageChildrenScreen extends StatelessWidget {
  const ManageChildrenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          
          childCard("Sofia", "5 anos", "12", "00/00/0000"),
          const SizedBox(height: AppConstants.elementSpacing),
          childCard("Arthur", "7 anos", "10", "00/00/0000"),
          
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
              icon: const Icon(Icons.add, color: AppConstants.iconLight),
              label: const Text(
                'Adicionar nova criança', 
                style: TextStyle(fontSize: 16, color: AppConstants.iconLight)
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.primaryOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget childCard(String nome, String idade, String refeicoes, String data) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.cardPadding),
      decoration: BoxDecoration(
        color: AppConstants.cardWhite,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppConstants.primaryOrange.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppConstants.cardWhite,
                child: const Icon(Icons.account_circle, size: 60, color: AppConstants.textBlack),
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
              expandedInfoBox("Refeições", refeicoes, Icons.restaurant),
              const SizedBox(width: 10),
              expandedInfoBox("Desde", data, Icons.calendar_today),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              actionButton(Icons.camera_alt),
              actionButton(Icons.edit),
              actionButton(Icons.delete),
            ],
          )
        ],
      ),
    );
  }

  Widget expandedInfoBox(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppConstants.primaryOrange.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 14, color: AppConstants.iconLight),
                const SizedBox(width: 5),
                Text(label, style: AppConstants.lightLabelStyle),
              ],
            ),
            Text(
              value, 
              style: const TextStyle(color: AppConstants.iconLight, fontWeight: FontWeight.bold)
            ),
          ],
        ),
      ),
    );
  }

  Widget actionButton(IconData icon) {
    return Container(
      width: 80,
      height: 35,
      decoration: BoxDecoration(
        color: AppConstants.primaryOrange,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: AppConstants.iconLight, size: 18),
    );
  }
}