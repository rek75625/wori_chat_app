import 'package:whatsapp_clone_py/features/contacts/domain/entities/contact_entity.dart';
import 'package:whatsapp_clone_py/features/conversations/domain/entities/conversation_entity.dart';

abstract class ConversationsState {}

class ConversationsInitial extends ConversationsState {}

class ConversationsLoading extends ConversationsState {}

class ConversationsLoaded extends ConversationsState {
  final List<ConversationEntity> conversations;

  ConversationsLoaded({required this.conversations});
}

class RecentContactsLoadedState extends ConversationsState {
  final List<ContactEntity> recentContacts;

  RecentContactsLoadedState({required this.recentContacts});
}

class ConversationsError extends ConversationsState {
  final String message;

  ConversationsError({required this.message});
}
