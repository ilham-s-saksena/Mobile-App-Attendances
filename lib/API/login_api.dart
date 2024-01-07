import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginApi {
  final String baseUrl;
  LoginApi({required this.baseUrl});
  final storage = FlutterSecureStorage();

  Future<String?> authenticate(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['token'];

      // Save the token securely
      await storage.write(key: 'Harbang.Januari@12', value: token);

      return token;
    } else {
      print('$baseUrl');
      throw Exception(
          'Failed to authenticate : ${response.statusCode}} : ${response.body}');
    }
  }
}
