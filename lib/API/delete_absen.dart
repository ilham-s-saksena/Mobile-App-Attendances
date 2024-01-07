import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DeleteApi {
  //

  //Ubah Sesuai dengan API
  final String baseUrl = "https://pkbmharbang.com/api/delete-absen";
  final storage = FlutterSecureStorage();

  Future<int?> deleteing(int id) async {
    final token = await storage.read(key: 'Harbang.Januari@12');
    final response = await http.delete(
      Uri.parse('$baseUrl'),
      headers: {'Authorization': 'Bearer $token'},
      body: jsonEncode({'id': id}), // Mengubah body menjadi string JSON
    );
    print("id absen yang dihapus $id");

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      throw Exception(
          'Failed to authenticate Status: ${response.statusCode}, body ${response.body}');
    }
  }
}
