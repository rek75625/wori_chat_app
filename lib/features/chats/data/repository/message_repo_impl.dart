import 'package:whatsapp_clone_py/features/chats/data/datasource/messages_remote_data_source.dart';
import 'package:whatsapp_clone_py/features/chats/domain/entities/message_entity.dart';
import 'package:whatsapp_clone_py/features/chats/domain/repository/message_repo.dart';

class MessageRepoImpl implements MessageRepository {
  final MessagesRemoteDataSource messagesRemoteDataSource;

  MessageRepoImpl({required this.messagesRemoteDataSource});
  @override
  Future<List<MessageEntity>> getFetchMessages(String conversationId) {
    throw UnimplementedError();
  }

  @override
  Future<void> sendMessage(MessageEntity message) {
    throw UnimplementedError();
  }
}
