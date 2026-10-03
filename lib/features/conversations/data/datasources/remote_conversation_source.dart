import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_clone_py/features/conversations/data/models/conversation_model.dart';

class RemoteConversationSource {
  final String baseUrl = "http://localhost:5000/api";
  final _storage = FlutterSecureStorage();

  Future<List<ConversationModel>> toGetConversations() async {
    String token = await _storage.read(key: "token") ?? "";
    final response = await http.get(
      Uri.parse("$baseUrl/conversations"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => ConversationModel.fromMap(e)).toList();
    } else {
      throw Exception("Failed to fetch conversations");
    }
  }
}
