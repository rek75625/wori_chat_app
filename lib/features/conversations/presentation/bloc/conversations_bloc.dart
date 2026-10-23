import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_py/constants/socket_service.dart';
import 'package:whatsapp_clone_py/features/conversations/domain/usecases/conversation_usecase.dart';
import 'package:whatsapp_clone_py/features/conversations/presentation/bloc/conversations_event.dart';
import 'package:whatsapp_clone_py/features/conversations/presentation/bloc/conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  final FetchConversationUsecase fetchConversationUsecase;

  final SocketService _socketService = SocketService();

  ConversationsBloc({required this.fetchConversationUsecase})
    : super(ConversationsInitial()) {
    on<GetConversationsEvent>(_onFetchConversations);
    _initializeSocketListeners();
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
      _socketService.socket.on('conversationUpdates', (dynamic data) {
        if (!isClosed) {
          add(GetConversationsEvent());
        }
      });
    } catch (e) {
      log("Error initializing socket listeners: $e");
    }
  }
}
