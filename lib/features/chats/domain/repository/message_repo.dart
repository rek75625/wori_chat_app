import 'package:whatsapp_clone_py/features/chats/domain/entities/message_entity.dart';

abstract class MessageRepository {
  Future<List<MessageEntity>> getFetchMessages(String conversationId);
  Future<void> sendMessage(MessageEntity message);
}
