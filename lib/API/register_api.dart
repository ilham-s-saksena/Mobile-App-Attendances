import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterApi {
  //-----

  // Ubah Sesuai dengan API
  final String baseUrl = "http://10.10.21.247:8000/api";
  final storage = FlutterSecureStorage();

  Future<String?> authenticate(String name, String email, String password,
      String konfirmasi_password) async {
    //----------
    final response = await http.post(
      Uri.parse('$baseUrl/register'),

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
