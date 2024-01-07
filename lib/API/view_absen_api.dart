import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ViewInputApi {
  // APIs

  // Ubah Sesuai dengan API
  final String baseUrl = "https://pkbmharbang.com/api/user-data-absen";
  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> UserDataAbsen(
      String? bulan, String? tahun) async {
    final token = await storage.read(key: 'Harbang.Januari@12');

    if (bulan == null || tahun == null) {
      final now = DateTime.now();
      bulan = now.month.toString();
      tahun = now.year.toString();
    }

    final response = await http.post(
      Uri.parse('$baseUrl'),
      headers: {'Authorization': 'Bearer $token'},
      body: {'bulan': bulan, 'tahun': tahun},
    );

    print("bulan = $bulan");
    print("tahun $tahun");

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      print(response.body);
      return jsonDecode(response.body);
    }
  }
}
