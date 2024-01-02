import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserManager extends ChangeNotifier {
  final storage = FlutterSecureStorage();
  String? authToken;

  Future<void> setAuthToken(String? token) async {
    authToken = token;
    if (token == null) {
      // Hapus token dari penyimpanan lokal saat logout
      await storage.delete(key: 'Harbang.Januari@12');
    } else {
      // Simpan atau perbarui token ke penyimpanan lokal saat login
      await storage.write(key: 'Harbang.Januari@12', value: token);
    }
    notifyListeners();
  }

  Future<void> logout() async {
    // Hapus token dari penyimpanan lokal saat logout
    await storage.delete(key: 'Harbang.Januari@12');
    authToken = null;
    notifyListeners();
  }

  bool get isAuthenticated => authToken != null;
}

class User {
  final int id;
  final String name;
  final String email;
  final String profilePhotoUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePhotoUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profilePhotoUrl: json['profile_photo_url'] ?? '',
    );
  }
}
