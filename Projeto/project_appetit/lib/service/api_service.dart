import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiService {
  static const String baseUrl = "http://localhost:8000";
  
  static Future<Map<String, dynamic>?> enviarFotos(XFile antes, XFile depois) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/analisar'));

      var bytesAntes = await antes.readAsBytes();
      var bytesDepois = await depois.readAsBytes();

      // Adicionando arquivo 'antes'
      request.files.add(await http.MultipartFile.fromBytes(
        'file_antes', 
        bytesAntes,
        filename: 'antes.jpg',
        contentType: MediaType('image', 'jpeg'),
      ));

      // Adicionando arquivo 'depois'
      request.files.add(await http.MultipartFile.fromBytes(
        'file_depois', 
        bytesDepois,
        filename: 'depois.jpg',
        contentType: MediaType('image', 'jpeg'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print("Erro na API: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Erro de conexão: $e");
      return null;
    }
  }
}