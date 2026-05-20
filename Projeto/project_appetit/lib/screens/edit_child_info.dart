import 'dart:convert'; 
import 'package:flutter/material.dart';
import 'package:project_appetit/dataconnect_generated/generated.dart';
import 'package:project_appetit/constants.dart';

class EditChildInfoScreen extends StatefulWidget {
  final String childId; 
  final String nomeInicial;
  final DateTime nascimentoInicial;
  final double pesoInicial;
  final String alergiasInicial;

  const EditChildInfoScreen({
    super.key,
    required this.childId,
    required this.nomeInicial,
    required this.nascimentoInicial,
    required this.pesoInicial,
    required this.alergiasInicial,
  });

  @override
  State<EditChildInfoScreen> createState() => _EditChildInfoScreenState();
}

class _EditChildInfoScreenState extends State<EditChildInfoScreen> {
  final _nomeController = TextEditingController();
  final _pesoController = TextEditingController();
  final _alergiasController = TextEditingController();
  DateTime? _selectedDate;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.nomeInicial;
    _pesoController.text = widget.pesoInicial.toString();
    _alergiasController.text = widget.alergiasInicial;
    _selectedDate = widget.nascimentoInicial;
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFFF7E4F),
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );

    if (dataSelecionada != null && dataSelecionada != _selectedDate) {
      setState(() {
        _selectedDate = dataSelecionada;
      });
    }
  }

  void _salvarAlteracoes() async {
    final nome = _nomeController.text.trim();
    final pesoStr = _pesoController.text.trim();
    final alergias = _alergiasController.text.trim();

    final pesoNum = double.tryParse(pesoStr);

    setState(() => _isLoading = true);

    try {
      var mutation = ExampleConnector.instance.atualizarPaciente(
        id: widget.childId,
      );

      if (nome != widget.nomeInicial) {
        mutation = mutation.nome(nome);
      }

      if (_selectedDate != null) {
        mutation = mutation.nascimento(
          DateTime(
            _selectedDate!.year,
            _selectedDate!.month,
            _selectedDate!.day,
          ),
        );
      }

      if (pesoNum != null && pesoNum != widget.pesoInicial) {
        mutation = mutation.peso(pesoNum.toDouble());
      }

      if (alergias != widget.alergiasInicial) {
        mutation = mutation.alergias(alergias);
      }

      await mutation.execute();

      if (mounted) {
        setState(() => _isLoading = false);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Dados atualizados!'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context);
      }
    } catch (e) {
      setState(() => _isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao atualizar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final dataFormatada = _selectedDate != null 
        ? "${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}"
        : "Selecione a data";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
              const SizedBox(height: 16),
              Image.asset('assets/imgs/morango.png', height: 100),
              const SizedBox(height: 16),
              const Text(
                "APPETIT",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              
              _buildLabel("Nome"),
              const SizedBox(height: 8),
              _buildTextField(_nomeController, "Digite o nome da criança", false, TextInputType.name),
              const SizedBox(height: 16),
              
              _buildLabel("Data de Nascimento"),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _selecionarData(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dataFormatada,
                        style: TextStyle(
                          color: _selectedDate != null ? Colors.black87 : Colors.black26,
                          fontSize: 16,
                        ),
                      ),
                      const Icon(Icons.calendar_today, color: Colors.black54, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              _buildLabel("Peso (kg)"),
              const SizedBox(height: 8),
              _buildTextField(_pesoController, "Digite o peso (ex: 15.4)", false, const TextInputType.numberWithOptions(decimal: true)),
              const SizedBox(height: 16),
              
              _buildLabel("Alergias / Restrições"),
              const SizedBox(height: 8),
              _buildTextField(_alergiasController, "Ex: Glúten, Lactose, Nenhuma", false, TextInputType.text),
              const SizedBox(height: 40),
              
              _isLoading
                  ? const CircularProgressIndicator(color: Colors.orange)
                  : SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _salvarAlteracoes,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.primaryOrange,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Salvar Alterações",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, bool obscure, TextInputType keyboardType) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black26),
        filled: true,
        fillColor: const Color(0xFFF8F8F8),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
      ),
    );
  }
}