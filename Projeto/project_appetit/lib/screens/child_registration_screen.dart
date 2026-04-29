import 'package:flutter/material.dart';
import 'package:project_appetit/constants.dart';
import 'package:project_appetit/dataconnect_generated/generated.dart'; 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ChildRegistrationScreen extends StatefulWidget {
  const ChildRegistrationScreen({super.key});

  @override
  State<ChildRegistrationScreen> createState() => _ChildRegistrationScreenState();
}

class _ChildRegistrationScreenState extends State<ChildRegistrationScreen> {
  final _nomeController = TextEditingController();
  final _nascimentoController = TextEditingController();
  final _pesoController = TextEditingController();
  final _alergiasController = TextEditingController();

  DateTime? _selectedDate;
  bool _isLoading = false;

  // Função para selecionar a data via calendário
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365)),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppConstants.primaryOrange),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _nascimentoController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _registrarPaciente() async {
    final nome = _nomeController.text.trim();
    final pesoStr = _pesoController.text.trim();
    final alergias = _alergiasController.text.trim();

    if (nome.isEmpty || _selectedDate == null) {
      _showSnackBar('Nome e data de nascimento são obrigatórios', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _showSnackBar('Erro: Você precisa estar logado.', isError: true);
        setState(() => _isLoading = false);
        return; 
      }

      final double? pesoNum = double.tryParse(pesoStr.replaceAll(',', '.'));

      await ExampleConnector.instance.criarPaciente(
        nome: nome,
        responsavelId: user.uid,
      )
      .nascimento(_selectedDate)
      .peso(pesoNum)
      .alergias(alergias)
      .execute();
      

      if (mounted) {
        setState(() => _isLoading = false);
        _showSnackBar('Cadastro realizado com sucesso!');
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) _showSnackBar('Erro ao salvar: $e', isError: true);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppConstants.textBlack),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Nova Criança", style: AppConstants.titleStyle),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("Nome completo *"),
              _buildTextField(_nomeController, "Nome da criança"),
              
              const SizedBox(height: 20),
              
              _buildLabel("Data de nascimento *"),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: _buildTextField(
                    _nascimentoController, 
                    "Toque para selecionar",
                    icon: Icons.calendar_today,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("Peso (kg)"),
                        _buildTextField(
                          _pesoController, 
                          "Ex: 15.5", 
                          keyboardType: const TextInputType.numberWithOptions(decimal: true)
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _buildLabel("Alergias ou restrições"),
              _buildTextField(
                _alergiasController, 
                "Ex: Amendoim, Lactose...", 
                maxLines: 3
              ),

              const SizedBox(height: 40),

              _isLoading
                  ? const Center(child: CircularProgressIndicator(color: AppConstants.primaryOrange))
                  : ElevatedButton(
                      onPressed: _registrarPaciente,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.primaryOrange,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Salvar Cadastro",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(label, style: AppConstants.sectionStyle),
    );
  }

  Widget _buildTextField(
    TextEditingController controller, 
    String hint, {
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: icon != null ? Icon(icon, color: AppConstants.primaryOrange) : null,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppConstants.borderOrange),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppConstants.borderOrange),
        ),
      ),
    );
  }
}