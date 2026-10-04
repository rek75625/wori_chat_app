import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:whatsapp_clone_py/features/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final String baseUrl = "http://localhost:5000/api/auth";

  final _storage = const FlutterSecureStorage();

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: jsonEncode({"email": email, "password": password}),
      headers: {"Content-Type": "application/json"},
    );
    String token = jsonDecode(response.body)["user"]["token"];
    await _storage.write(key: "token", value: token);

    // Fixed: Added ["user"] to safely extract the user object matching your Node backend
    return UserModel.fromMap(jsonDecode(response.body)["user"]);
  }

  Future<UserModel> register({
    // Fixed typo: changed 'resgister' to 'register'
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
      }),
      headers: {"Content-Type": "application/json"},
    );
    return UserModel.fromMap(jsonDecode(response.body)["user"]);
  }
}
