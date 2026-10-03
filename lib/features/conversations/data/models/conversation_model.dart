import 'package:whatsapp_clone_py/features/conversations/domain/entities/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  ConversationModel({
    required super.id,
    required super.participantName,
    required super.lastMessage,
    required super.lastMessageTime,
  });

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      id: map['conversation_id'] ?? '',
      participantName: map['participant_name'] ?? '',
      lastMessage: map['last_message'] ?? '',
      lastMessageTime: DateTime.parse(map['last_message_time']),
    );
  }
}
