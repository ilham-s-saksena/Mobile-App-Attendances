import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class InputApi {
  // API sudah di Hosting
  final String baseUrl = "https://pkbmharbang.com/api/create-absen";
  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> inputAbsent(
      String tgl, String jam, String kelas, String mapel, String materi) async {
    //------------
    final token = await storage.read(key: 'Harbang.Januari@12');

    if (token == null) {
      throw Exception('Token not found');
    }

    //----------
    final response = await http.post(
      Uri.parse('$baseUrl'),

      //---------
      headers: {'Authorization': 'Bearer $token'},
      body: {
        'tgl': tgl,
        'jam': jam,
        'kelas': kelas,
        'mapel': mapel,
        'materi': materi,
      },
    );

    if (response.statusCode == 201) {
      final message = jsonDecode(response.body);
      return message;
    } else {
      final message = jsonDecode(response.body);
      final errorss = message['message'];
      throw Exception('Keterangan: ${errorss}');
    }
  }
}
