import 'package:flutter/material.dart';
import 'package:project_appetit/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

// --- CLASSE DO MODELO ---
class AlimentoModel {
  final String nome;
  final String porcentagem;
  final Color corFundo;
  final Color corBorda;

  AlimentoModel({
    required this.nome,
    required String porcentagem,
  }) : porcentagem = "$porcentagem%",
       corFundo = int.parse(porcentagem) >= 70 
           ? const Color(0xFFF1F8E9) 
           : int.parse(porcentagem) >= 40 
               ? const Color(0xFFFFFDE7) 
               : const Color(0xFFFDECEA),
       corBorda = int.parse(porcentagem) >= 70 
           ? const Color(0xFF81C784) 
           : int.parse(porcentagem) >= 40 
               ? const Color(0xFFFFF176) 
               : const Color(0xFFE57373);
}

class DocumentsScreen extends StatelessWidget {
  final List<AlimentoModel> alimentosIdentificados = [
    AlimentoModel(nome: "Arroz", porcentagem: "70"),
    AlimentoModel(nome: "Feijão", porcentagem: "50"),
    AlimentoModel(nome: "Carne", porcentagem: "10"),
  ];

  DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Cor de destaque padronizada (0xFFF67B55)
    const Color highlightOrange = Color(0xFFF67B55);

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor, // 0xFFFFF8F5
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true, // Centralizado conforme o padrão
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back.svg', // Implementação do back.svg
            width: 24,
          ),
          onPressed: () {
            // Volta para a HomeScreen
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Reconhecimento refeições", 
          style: AppConstants.titleStyle
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildChildHeader("Sofia", "5 anos", highlightOrange),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(child: _buildPhotoHolder(highlightOrange)),
                const SizedBox(width: 15),
                Expanded(child: _buildPhotoHolder(highlightOrange)),
              ],
            ),
            const SizedBox(height: 30),
            const Text("Alimentos identificados", style: AppConstants.sectionStyle),
            const SizedBox(height: 15),
            ...alimentosIdentificados.map((alimento) => _buildFoodTile(alimento)).toList(),
            const SizedBox(height: 30),
            const Text("Resumo", style: AppConstants.sectionStyle),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryCard("1", "Bem aceitos", const Color(0xFF81C784)),
                _buildSummaryCard("1", "Parciais", const Color(0xFFFFF176)),
                _buildSummaryCard("1", "Rejeitados", const Color(0xFFE57373)),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildChildHeader(String nome, String idade, Color orangeColor) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor, // Fundo ajustado para não ficar branco
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: orangeColor.withOpacity(0.3), 
          width: 1.2
        ),
      ),
      child: Row(
        children: [
          // Substituído pelo seu SVG de perfil
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
              Text(idade, style: const TextStyle(color: AppConstants.textGrey, fontSize: 15)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPhotoHolder(Color orangeColor) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor, // Fundo ajustado
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: orangeColor.withOpacity(0.3), 
          width: 1.2
        ),
      ),
      child: const Center(
        child: Icon(Icons.image_outlined, size: 45, color: Color(0xFFCCCCCC)),
      ),
    );
  }

  Widget _buildFoodTile(AlimentoModel alimento) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: alimento.corFundo,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: alimento.corBorda, width: 1.2),
      ),
      child: Row(
        children: [
          const Icon(Icons.edit_outlined, size: 18, color: AppConstants.textBlack),
          const SizedBox(width: 12),
          Text(alimento.nome, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const Spacer(),
          Text(alimento.porcentagem, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String valor, String label, Color cor) {
    return Container(
      width: 105,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: cor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: cor.withOpacity(0.4), width: 1.2),
      ),
      child: Column(
        children: [
          Text(valor, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: cor)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: AppConstants.textBlack, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}