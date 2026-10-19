import 'package:whatsapp_clone_py/features/conversations/domain/entities/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  ConversationModel({
    required super.id,
    required super.participantName,
    super.lastMessage, // ✅ Allowed to be null or optional
    super.lastMessageTime, // ✅ Allowed to be null or optional
  });

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      id: map['conversation_id']?.toString() ?? '',
      participantName: map['participant_name']?.toString() ?? 'Unknown User',

      // ✅ Null-safe fallback: If no messages exist yet, use placeholder string
      lastMessage: map['last_message']?.toString() ?? 'No messages yet',

      // ✅ Null-safe conditional date parsing: Prevent DateTime.parse(null) crash
      lastMessageTime: map['last_message_time'] != null
          ? DateTime.parse(map['last_message_time'].toString())
          : null,
    );
  }
}
