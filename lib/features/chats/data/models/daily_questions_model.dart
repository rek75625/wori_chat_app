import 'package:whatsapp_clone_py/features/chats/domain/entities/daily_questions_entity.dart';

class DailyQuestionsModel extends DailyQuestionsEntity {
  DailyQuestionsModel({required super.content});

  factory DailyQuestionsModel.fromMap(Map<String, dynamic> map) {
    return DailyQuestionsModel(
      content: map['question'] ?? "No questions found",
    );
  }
}
