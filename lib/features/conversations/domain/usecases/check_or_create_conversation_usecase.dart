import 'package:whatsapp_clone_py/features/conversations/domain/repositories/conversation_repo.dart';

class CheckOrCreateConversationUseCase {
  final ConversationRepository conversationRepository;

  CheckOrCreateConversationUseCase({required this.conversationRepository});
  Future<String> callToCheckOrCreate({required String contactId}) async {
    return await conversationRepository.checkOrCreateConversation(
      contactId: contactId,
    );
  }
}
