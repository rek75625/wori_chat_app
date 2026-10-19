import 'package:whatsapp_clone_py/features/conversations/domain/entities/conversation_entity.dart';

abstract class ConversationRepository {
  Future<List<ConversationEntity>> getConversations();

  Future<String> checkOrCreateConversation({required String contactId});
}
