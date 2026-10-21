import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:whatsapp_clone_py/features/contacts/data/models/contact_model.dart';

class ContactRemoteDataSource {
  // FIX 1: Make baseUrl a dynamic getter to completely avoid web/mobile network routing cross-pollution
  String get baseUrl =>
      kIsWeb ? "http://localhost:5000/api" : "http://10.0.2.2:5000/api";

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<List<ContactModel>> fetchContacts() async {
    final token = await _storage.read(key: "token") ?? "";

    try {
      final response = await http
          .get(
            Uri.parse("$baseUrl/contacts"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 10)); // Added a timeout safety net

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((e) => ContactModel.fromMap(e as Map<String, dynamic>))
            .toList();
      } else {
        // Parse the error message returned from your Express backend if available
        final errorMsg = _extractBackendError(response.body);
        throw Exception(errorMsg);
      }
    } catch (e) {
      throw Exception("Network connection failed while fetching contacts: $e");
    }
  }

  Future<void> addContacts({required String email}) async {
    final token = await _storage.read(key: "token") ?? "";

    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/contacts"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"contactEmail": email}),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode < 200 || response.statusCode >= 300) {
        // FIX 2: Extract clean error message strings from backend response text bodies
        final errorMsg = _extractBackendError(response.body);
        throw Exception(errorMsg);
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll("Exception: ", ""));
    }
  }

  // Helper utility to read JSON error parameters sent back from Express
  String _extractBackendError(String responseBody) {
    try {
      final Map<String, dynamic> decoded = jsonDecode(responseBody);
      return decoded['error'] ?? "Unknown server validation error occurred.";
    } catch (_) {
      return "Server error payload parsing failed.";
    }
  }

  Future<List<ContactModel>> fetchRecentContacts() async {
    final token = await _storage.read(key: "token") ?? "";

    try {
      final response = await http
          .get(
            Uri.parse("$baseUrl/contacts/recent"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode < 200 || response.statusCode >= 300) {
        // FIX 2: Extract clean error message strings from backend response text bodies
        // final errorMsg = _extractBackendError(response.body);

        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => ContactModel.fromMap(e)).toList();
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll("Exception: ", ""));
    }
  }
}
