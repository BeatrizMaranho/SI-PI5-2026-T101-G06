import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class ApiService {
  static String get baseUrl {
    if (kIsWeb) {
      return "http://localhost:8000";
    } else if (Platform.isAndroid) {
      return "http://10.0.2.2:8000";
    } else {
      return "http://localhost:8000";
    }
  }

  static Future<List<Map<String, dynamic>>> buscarPacientes(
    String responsavelId,
  ) async {
    try {
      final String idLimpo = responsavelId.trim();
      final url = Uri.parse('$baseUrl/pacientes/$idLimpo');

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

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);

        if (decodedData is List) {
          return decodedData
              .map(
                (item) => {
                  "id": item['id']?.toString() ?? '',
                  "nome": item['nome']?.toString() ?? 'Sem nome',
                },
              )
              .toList();
        } else {
          print("Backend retornou formato inesperado: $decodedData");
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      print("Erro de conexao: $e");
      return [];
    }
  }

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

      request.files.add(
        http.MultipartFile.fromBytes(
          'file_antes',
          bytesAntes,
          filename: 'antes.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      request.files.add(
        http.MultipartFile.fromBytes(
          'file_depois',
          bytesDepois,
          filename: 'depois.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      print("Enviando imagens para analise...");
      print("Paciente: $nomeCrianca");

      var streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
      );
      var response = await http.Response.fromStream(streamedResponse);

      print("Status Code YOLO: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Analise concluida");
        return json.decode(response.body);
      } else {
        print("Erro YOLO: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Erro no envio das fotos: $e");
      return null;
    }
  }
}
