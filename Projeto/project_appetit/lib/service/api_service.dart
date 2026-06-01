import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class ApiService {
  static const List<String> _webBaseUrls = [
    "http://127.0.0.1:8080",
    "http://localhost:8080",
  ];

  static String get baseUrl {
    if (Platform.isAndroid) {
      return "http://10.0.2.2:8080";
    }
    return "http://127.0.0.1:8080";
  }

  // Tenta cada URL da lista até uma funcionar
  static Future<http.Response?> _tentarUrls(
    Future<http.Response> Function(String baseUrl) requestBuilder,
  ) async {
    if (!kIsWeb) {
      try {
        return await requestBuilder(baseUrl);
      } catch (_) {
        return null;
      }
    }

    for (final url in _webBaseUrls) {
      try {
        final response = await requestBuilder(url);
        return response;
      } catch (_) {
        continue;
      }
    }
    return null;
  }

  static Future<bool> verificarEmailExistente(String email) async {
    try {
      final response = await _tentarUrls((base) async {
        return await http
            .post(
              Uri.parse('$base/verificar-email'),
              headers: {"Content-Type": "application/json"},
              body: json.encode({"email": email}),
            )
            .timeout(const Duration(seconds: 10));
      });

      if (response != null && response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['existe'] == true;
      }
      return false;
    } catch (e) {
      print("Erro ao verificar email: $e");
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> buscarPacientes(
    String responsavelId,
  ) async {
    try {
      final String idLimpo = responsavelId.trim();

      final response = await _tentarUrls((base) async {
        final url = Uri.parse('$base/pacientes/$idLimpo');
        print("Tentando URL: $url");
        return await http
            .get(
              url,
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              },
            )
            .timeout(const Duration(seconds: 10));
      });

      if (response != null && response.statusCode == 200) {
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
        }
      }
      return [];
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
    if (!kIsWeb) {
      return _enviarFotosComBase(baseUrl, antes, depois, nomeCrianca);
    }

    for (final url in _webBaseUrls) {
      print("Tentando enviar fotos para: $url");
      final resultado = await _enviarFotosComBase(
        url,
        antes,
        depois,
        nomeCrianca,
      );
      if (resultado != null) return resultado;
    }

    return null;
  }

  static Future<Map<String, dynamic>?> _enviarFotosComBase(
    String base,
    XFile antes,
    XFile depois,
    String nomeCrianca,
  ) async {
    try {
      final url = Uri.parse('$base/analisar');
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
      print("Erro no envio das fotos com base $base: $e");
      return null;
    }
  }
}
