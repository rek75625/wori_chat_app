import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_py/constants/socket_service.dart';
import 'package:whatsapp_clone_py/features/contacts/domain/usecases/recent_contact_usecase.dart';
import 'package:whatsapp_clone_py/features/conversations/domain/usecases/conversation_usecase.dart';
import 'package:whatsapp_clone_py/features/conversations/presentation/bloc/conversations_event.dart';
import 'package:whatsapp_clone_py/features/conversations/presentation/bloc/conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  final FetchConversationUsecase fetchConversationUsecase;
  final RecentContactUsecase recentContactUsecase;
  final SocketService _socketService = SocketService();

  ConversationsBloc({
    required this.fetchConversationUsecase,
    required this.recentContactUsecase,
  }) : super(ConversationsInitial()) {
    on<GetConversationsEvent>(_onFetchConversations);
    _initializeSocketListeners();
    on<LoadRecentContactsEvent>(_onLoadRecentContactsEvent);
  }

  Future<void> _onFetchConversations(
    GetConversationsEvent event,
    Emitter<ConversationsState> emit,
  ) async {
    emit(ConversationsLoading());
    try {
      final conversations = await fetchConversationUsecase
          .callToGetConversations();
      emit(ConversationsLoaded(conversations: conversations));
    } catch (e) {
      emit(ConversationsError(message: "Failed to fetch conversations"));
    }
  }

  void _initializeSocketListeners() {
    try {
      _socketService.socket.on('conversationUpdates', (data) {
        if (!isClosed) {
          add(GetConversationsEvent());
        }
      });
    } catch (e) {
      log("Error initializing socket listeners: $e");
    }
  }

  Future<void> _onLoadRecentContactsEvent(
    LoadRecentContactsEvent event,
    Emitter<ConversationsState> emit,
  ) async {
    emit(ConversationsLoading());
    try {
      final recentContacts = await recentContactUsecase.callGetRecentContacts();
      emit(RecentContactsLoadedState(recentContacts: recentContacts));
    } catch (e) {
      emit(ConversationsError(message: "Failed to fetch conversations"));
    }
  }
}
