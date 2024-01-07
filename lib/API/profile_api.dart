import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
// API sudah di Hosting
  static const String baseUrl = "https://pkbmharbang.com/api/profile";
  static final storage = FlutterSecureStorage();

  static Future<String?> uploadImage(File imageFile, String name, String email,
      String? password, String? passwordConfirm) async {
    final token = await ApiService.storage.read(key: 'Harbang.Januari@12');

    try {
      final uri = Uri.parse(baseUrl);
      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = "Bearer $token"
        ..files.add(await http.MultipartFile.fromPath('image', imageFile.path))
        ..fields['name'] = name
        ..fields['email'] = email
        ..fields['password'] = password!
        ..fields['passwordConfirm'] = passwordConfirm!;

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: $responseBody');

      if (response.statusCode == 201) {
        return responseBody;
      } else {
        return responseBody;
      }
    } catch (e) {
      return "'message' : '$e'";
    }
  }

  static Future<String?> uploadNoImage(String name, String email,
      String? password, String? passwordConfirm) async {
    final token = await ApiService.storage.read(key: 'Harbang.Januari@12');

    try {
      final uri = Uri.parse(baseUrl);
      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = "Bearer $token"
        ..fields['name'] = name
        ..fields['email'] = email
        ..fields['password'] = password!
        ..fields['passwordConfirm'] = passwordConfirm!;

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 201) {
        return responseBody;
      } else {
        return responseBody;
      }
    } catch (e) {
      return "'message' : '$e'";
    }
  }
}
