import 'package:whatsapp_clone_py/features/conversations/domain/entities/conversation_entity.dart';
import 'package:whatsapp_clone_py/features/conversations/domain/repositories/conversation_repo.dart';

class FetchConversationUsecase {
  final ConversationRepository repository;

  FetchConversationUsecase(this.repository);

  Future<List<ConversationEntity>> callToGetConversations() async {
    return await repository.getConversations();
  }
}
