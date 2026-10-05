import 'package:whatsapp_clone_py/features/chats/domain/entities/message_entity.dart';
import 'package:whatsapp_clone_py/features/chats/domain/repository/message_repo.dart';

class FetchMessageUsecase {
  final MessageRepository messageRepository;

  FetchMessageUsecase({required this.messageRepository});

  Future<List<MessageEntity>> callToGetMessages(String conversationId) async {
    return await messageRepository.getFetchMessages(conversationId);
  }
}
