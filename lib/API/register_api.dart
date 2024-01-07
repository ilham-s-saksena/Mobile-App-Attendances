import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterApi {
// API sudah di Hosting
  final String baseUrl = "https://pkbmharbang.com/api/register";
  final storage = FlutterSecureStorage();

  Future<String?> authenticate(String name, String email, String password,
      String konfirmasi_password) async {
    //----------
    final response = await http.post(
      Uri.parse('$baseUrl'),

      //---------
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 201) {
      final token =
          "Registrasi Berhasil! Silahkan Login dengan akun yang sudah kamu buat";

      return token;
    } else {
      throw Exception('Failed to authenticate');
    }
  }
}
