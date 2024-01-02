import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterApi {
  //

  // Ubah sesuai dengan API
  final String baseUrl = "http://10.10.21.247:8000/api";
  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> dashboardData() async {
    final token = await storage.read(key: 'Harbang.Januari@12');

    final response = await http.get(
      Uri.parse('$baseUrl/dashboard'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Terjadi Kesalahan');
    }
  }
}
