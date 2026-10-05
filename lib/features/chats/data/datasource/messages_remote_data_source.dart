import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:whatsapp_clone_py/features/chats/data/models/message_model.dart';
import 'package:whatsapp_clone_py/features/chats/domain/entities/message_entity.dart';
import 'package:http/http.dart' as http;

class MessagesRemoteDataSource {
  final String baseUrl = kIsWeb
      ? "http://localhost:5000/api"
      : "http://10.0.2.2:5000/api";

  final _storage = const FlutterSecureStorage();

  Future<List<MessageEntity>> fetchMessages(String conversationId) async {
    final token = await _storage.read(key: "token") ?? "";
    final response = await http.get(
      Uri.parse("$baseUrl/messages/$conversationId"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => MessageModel.fromMap(e)).toList();
    } else {
      throw Exception("Failed to fetch messages: ${response.statusCode}");
    }
  }
}
