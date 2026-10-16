import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:whatsapp_clone_py/features/contacts/data/models/contact_model.dart';

class ContactRemoteDataSource {
  final String baseUrl = kIsWeb
      ? "http://localhost:5000/api"
      : "http://10.0.2.2:5000/api";

  final _storage = const FlutterSecureStorage();

  Future<List<ContactModel>> fetchContacts() async {
    final token = await _storage.read(key: "token") ?? "";
    final response = await http.get(
      Uri.parse("$baseUrl/contacts"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => ContactModel.fromMap(e)).toList();
    } else {
      throw Exception("Failed to fetch messages: ${response.statusCode}");
    }
  }

  Future<void> addContacts({required String email}) async {
    final token = await _storage.read(key: "token") ?? "";
    final response = await http.post(
      Uri.parse("$baseUrl/contacts"),
      body: {'contactEmail': email},
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to add contact: ${response.statusCode}");
    }
  }
}
