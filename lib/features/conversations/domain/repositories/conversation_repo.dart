import 'package:whatsapp_clone_py/features/conversations/domain/entities/conversation_entity.dart';

abstract class ConversationRepository {
  Future<List<ConversationEntity>> getConversations();
  // Future<ConversationEntity> getConversationById(String id);
  // Future<void> createConversation(ConversationEntity conversation);
  // Future<void> updateConversation(ConversationEntity conversation);
  // Future<void> deleteConversation(String id);
}
