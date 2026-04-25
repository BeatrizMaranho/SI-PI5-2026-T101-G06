import 'package:flutter/material.dart';
import 'package:project_appetit/constants.dart';

class ChildRegistrationScreen extends StatefulWidget {
  const ChildRegistrationScreen({super.key});

  @override
  State<ChildRegistrationScreen> createState() => _ChildRegistrationScreenState();
}

class _ChildRegistrationScreenState extends State<ChildRegistrationScreen> {
  // Controllers em inglês para facilitar o mapeamento com os campos do Firestore
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _allergyController = TextEditingController();

  @override
  void dispose() {
    // Importante limpar os controllers para evitar vazamento de memória
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _allergyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppConstants.textBlack),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Gerenciar crianças", style: AppConstants.titleStyle),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Criancas cadastradas",
              style: AppConstants.sectionStyle,
            ),
            const SizedBox(height: 30),
            
            // Reutilizando o helper para manter a interface limpa
            _buildInputField(
              label: "Nome",
              hint: "Digite o nome",
              controller: _nameController,
            ),
            _buildInputField(
              label: "Idade",
              hint: "Ex: 5",
              controller: _ageController,
              keyboardType: TextInputType.number,
            ),
            _buildInputField(
              label: "Peso",
              hint: "Ex: 20kg",
              controller: _weightController,
              keyboardType: TextInputType.number,
            ),
            _buildInputField(
              label: "Intolerância/Alergia",
              hint: "Ex: Lactose, Glúten...",
              controller: _allergyController,
            ),
            
            const SizedBox(height: 30),

            // Botão Principal de Cadastro
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Aqui você chamará sua função de Create do Firebase
                  // Ex: firestore.collection('children').add({...})
                  print("Iniciando cadastro de: ${_nameController.text}");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Cadastrar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Componente de Campo de Entrada customizado conforme o print
  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.elementSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppConstants.sectionStyle.copyWith(
              fontWeight: FontWeight.w500,
              color: AppConstants.textBlack.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(color: AppConstants.textBlack),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFFD1D1D1)),
              filled: true,
              fillColor: AppConstants.cardWhite,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              // Estilização das bordas para o visual do print
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
                borderSide: const BorderSide(color: AppConstants.primaryOrange, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}