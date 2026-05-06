import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class ApiService {
  // 🔥 Ajuste dependendo de onde roda:
  // Web: localhost
  // Android Emulator: 10.0.2.2
  // Celular físico: IP da máquina (ex: 192.168.0.105)
  static const String baseUrl = "http://localhost:8000";

  // ============================
  // 1. BUSCAR PACIENTES
  // ============================
  static Future<List<Map<String, dynamic>>> buscarPacientes(String responsavelId) async {
    try {
      final String idLimpo = responsavelId.trim();
      final url = Uri.parse('$baseUrl/pacientes/$idLimpo');

      print("\n--- DEBUG FLUTTER ---");
      print("URL: $url");
      print("UID enviado: $idLimpo");

      final response = await http
          .get(
            url,
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
          )
          .timeout(const Duration(seconds: 10));

      print("Status Code: ${response.statusCode}");
      print("Resposta bruta: ${response.body}");

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        return data.map((item) => {
              "id": item['id'].toString(),
              "nome": item['nome'].toString(),
            }).toList();
      } else {
        print("❌ Erro na API: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("❌ Erro de conexão: $e");
      return [];
    }
  }

  // ============================
  // 2. ENVIAR FOTOS PARA ANÁLISE
  // ============================
  static Future<Map<String, dynamic>?> enviarFotos(
    XFile antes,
    XFile depois,
    String nomeCrianca,
  ) async {
    try {
      final url = Uri.parse('$baseUrl/analisar');
      var request = http.MultipartRequest('POST', url);

      request.fields['nome_crianca'] = nomeCrianca;

      var bytesAntes = await antes.readAsBytes();
      var bytesDepois = await depois.readAsBytes();

      request.files.add(http.MultipartFile.fromBytes(
        'file_antes',
        bytesAntes,
        filename: 'antes.jpg',
        contentType: MediaType('image', 'jpeg'),
      ));

      request.files.add(http.MultipartFile.fromBytes(
        'file_depois',
        bytesDepois,
        filename: 'depois.jpg',
        contentType: MediaType('image', 'jpeg'),
      ));

      print("\n📸 Enviando imagens para análise...");
      print("Paciente: $nomeCrianca");

      var streamedResponse = await request.send().timeout(const Duration(seconds: 30));
      var response = await http.Response.fromStream(streamedResponse);

      print("Status Code YOLO: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("✅ Análise concluída");
        return json.decode(response.body);
      } else {
        print("❌ Erro YOLO: ${response.body}");
        return null;
      }
    } catch (e) {
      print("❌ Erro no envio das fotos: $e");
      return null;
    }
  }
}