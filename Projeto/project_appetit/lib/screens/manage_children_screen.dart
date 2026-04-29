import 'package:flutter/material.dart';
import 'package:project_appetit/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_appetit/screens/tirar_fotos_screen.dart';
import 'child_registration_screen.dart';
import 'package:project_appetit/dataconnect_generated/generated.dart';
import 'dart:developer' as dev; // Import para logs mais limpos
import 'package:intl/intl.dart';

class ManageChildrenScreen extends StatelessWidget {
  final String userId;

  const ManageChildrenScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Gerenciar crianças',
          style: AppConstants.titleStyle,
        ),
      ),
      body: FutureBuilder(
        future: ExampleConnector.instance.listarMeusPacientes(responsavelId: userId).execute(),
        builder: (context, snapshot) {
          dev.log('Buscando pacientes para o userId: $userId', name: 'APP_DEBUG');

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppConstants.primaryOrange));
          }

          if (snapshot.hasError) {
            dev.log('ERRO NO FUTUREBUILDER: ${snapshot.error}', name: 'APP_DEBUG', error: snapshot.error);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Erro ao carregar dados"),
                  const SizedBox(height: 10),
                  Text("${snapshot.error}", style: const TextStyle(fontSize: 10, color: Colors.red)),
                ],
              ),
            );
          }

          dev.log('Dados recebidos: ${snapshot.data?.data.pacientes}', name: 'APP_DEBUG');

          final pacientes = snapshot.data?.data.pacientes ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Crianças cadastradas',
                  style: AppConstants.sectionStyle,
                ),
                const SizedBox(height: AppConstants.defaultPadding),
                
                if (pacientes.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text("Nenhuma criança cadastrada", style: TextStyle(color: AppConstants.textGrey)),
                    ),
                  ),

                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pacientes.length,
                  separatorBuilder: (context, index) => const SizedBox(height: AppConstants.elementSpacing),
                  itemBuilder: (context, index) {
                      final paciente = pacientes[index];
                      
                      dev.log('Processando paciente: ${paciente.nome}, Nasc: ${paciente.nascimento}', name: 'APP_DEBUG');

                      final int idadeCalculada = calcularIdade(paciente.nascimento);

                      return childCard(
                        context, 
                        paciente.nome, 
                        "$idadeCalculada anos", 
                        '0', 
                        DateFormat('dd/MM/yyyy').format(paciente.criadoEm.toDateTime()),
                        AppConstants.borderOrange, 
                        AppConstants.primaryOrange,
                        onCameraTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TirarFotosScreen(/*childId: paciente.id*/),
                            ),
                          );
                        },
                      );                      
                    },
                ),
                
                const SizedBox(height: AppConstants.elementSpacing),

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
                      style: TextStyle(
                        fontSize: 18, 
                        color: AppConstants.iconLight, 
                        fontWeight: FontWeight.bold
                      )
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryOrange,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius)
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.elementSpacing),
              ],
            ),
          );
        },
      ),
    );
  }

  // Restante dos métodos (calcularIdade, childCard, etc) permanecem iguais...

  int calcularIdade(dynamic nascimento) {
    if (nascimento == null) return 0;
    
    // Converte para DateTime se for String, caso já não seja
    DateTime dataNasc = nascimento is String 
        ? DateTime.parse(nascimento) 
        : nascimento;
        
    DateTime hoje = DateTime.now();
    int idade = hoje.year - dataNasc.year;

    // Ajusta se o aniversário ainda não ocorreu este ano
    if (hoje.month < dataNasc.month || 
        (hoje.month == dataNasc.month && hoje.day < dataNasc.day)) {
      idade--;
    }

    return idade;
  }
  Widget childCard(
    BuildContext context,
    String nome, 
    String idade, 
    String refeicoes, 
    String data,
    Color statsColor, 
    Color actionColor,
    {required VoidCallback onCameraTap}
    ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.cardPadding),
      decoration: BoxDecoration(
        color: AppConstants.cardWhite, 
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(
          color: statsColor.withOpacity(0.3), 
          width: 1.2,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(
                  'assets/icons/user-img.svg',
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
              expandedInfoBox("Refeições", refeicoes, Icons.restaurant, statsColor),
              const SizedBox(width: 10),
              expandedInfoBox("Desde", data, Icons.calendar_today, statsColor),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              actionButton(Icons.camera_alt, actionColor, onTap: onCameraTap),
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
          color: statsColor,
          borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
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
            const SizedBox(height: 4),
            Text(
              value, 
              style: const TextStyle(
                color: AppConstants.iconLight, 
                fontWeight: FontWeight.bold, 
                fontSize: 16
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget actionButton(IconData icon, Color actionColor, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      width: 80,
      height: 45,
      decoration: BoxDecoration(
        color: actionColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: AppConstants.iconLight, size: 20),
      ),
    );
  }
}