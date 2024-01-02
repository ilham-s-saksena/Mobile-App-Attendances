import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ViewInputApi {
  // APIs

  // Ubah Sesuai dengan API
  final String baseUrl = "http://10.10.21.247:8000/api";
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
      Uri.parse('$baseUrl/user-data-absen'),
      headers: {'Authorization': 'Bearer $token'},
      body: {'bulan': bulan, 'tahun': tahun},
    );

    print("bulan = $bulan");
    print("tahun $tahun");

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      print("bulan = $bulan");
      print("tahun $tahun");
      return jsonDecode(response.body);
    }
  }
}
