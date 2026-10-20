import 'package:whatsapp_clone_py/features/chats/domain/entities/daily_questions_entity.dart';
import 'package:whatsapp_clone_py/features/chats/domain/repository/message_repo.dart';

class FetchDailyQuestionsUsecase {
  final MessageRepository messageRepository;

  FetchDailyQuestionsUsecase({required this.messageRepository});

  Future<DailyQuestionsEntity> callToGetDailyQuestions(String content) async {
    return await messageRepository.dailyQuestions(content);
  }
}
