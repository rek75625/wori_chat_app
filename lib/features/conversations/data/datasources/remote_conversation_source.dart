import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart'; // Import kIsWeb
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_clone_py/features/conversations/data/models/conversation_model.dart';

class RemoteConversationSource {
  // Automatically switches IP address based on testing platform environment
  final String baseUrl = kIsWeb ? "http://localhost:5000/api" : "http://10.0.2";

  final _storage = const FlutterSecureStorage();

  Future<List<ConversationModel>> toGetConversations() async {
    final token = await _storage.read(key: "token") ?? "";
    log(
      "Sending Token to Server: Bearer $token",
    ); // Debug to ensure token isn't blank

    final response = await http.get(
      Uri.parse("$baseUrl/conversations"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map<ConversationModel>(
            (e) => ConversationModel.fromMap(e as Map<String, dynamic>),
          )
          .toList();
    } else {
      log(
        "Failed to fetch conversations: ${response.statusCode} - Body: ${response.body}",
      );
      throw Exception("Failed to fetch conversations: ${response.statusCode}");
    }
  }
}
