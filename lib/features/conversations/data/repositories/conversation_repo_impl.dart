import 'package:whatsapp_clone_py/features/conversations/data/datasources/remote_conversation_source.dart';
import 'package:whatsapp_clone_py/features/conversations/domain/entities/conversation_entity.dart';
import 'package:whatsapp_clone_py/features/conversations/domain/repositories/conversation_repo.dart';

class ConversationRepoImpl extends ConversationRepository {
  final RemoteConversationSource remoteConversationSource;

  ConversationRepoImpl({required this.remoteConversationSource});
  @override
  Future<List<ConversationEntity>> getConversations() async {
    return await remoteConversationSource.toGetConversations();
  }
}
