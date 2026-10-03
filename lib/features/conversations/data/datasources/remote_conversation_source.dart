import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_clone_py/features/conversations/data/models/conversation_model.dart';

class RemoteConversationSource {
  // Use "10.0.2.2" for Android Emulator or your computer's Wi-Fi IP for real devices
  final String baseUrl = "http://localhost:5000/api/conversations";
  final _storage = const FlutterSecureStorage();

  Future<List<ConversationModel>> toGetConversations() async {
    final token = await _storage.read(key: "token") ?? "";

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      // Strictly type cast the mapping iteration to prevent runtime errors
      return data
          .map<ConversationModel>(
            (e) => ConversationModel.fromMap(e as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw Exception("Failed to fetch conversations: ${response.statusCode}");
    }
  }
}
