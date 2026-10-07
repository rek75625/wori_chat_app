import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:whatsapp_clone_py/constants/socket_service.dart';
import 'package:whatsapp_clone_py/features/chats/domain/entities/message_entity.dart';
import 'package:whatsapp_clone_py/features/chats/domain/usecases/fetch_message_usecase.dart';
import 'package:whatsapp_clone_py/features/chats/presentation/bloc/chat_event.dart';
import 'package:whatsapp_clone_py/features/chats/presentation/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FetchMessageUsecase fetchMessageUsecase;
  final SocketService _socketService = SocketService();
  final List<MessageEntity> _messages = [];
  final _storage = FlutterSecureStorage();

  ChatBloc({required this.fetchMessageUsecase}) : super(ChatLoadingState()) {
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<ReceiveMessageEvent>(_onReceiveMessage);
  }

  Future<void> _onLoadMessages(
    LoadMessagesEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoadingState());
    try {
      final messages = await fetchMessageUsecase.callToGetMessages(
        event.conversationId,
      );
      _messages.clear();
      _messages.addAll(messages);
      emit(ChatLoadedState(List.from(_messages)));
      _socketService.socket.emit("Joined Conversation", event.conversationId);
      _socketService.socket.on("new Message", (data) {
        if (kDebugMode) {
          print("step1 - receive");
        }
      });
    } catch (e) {
      emit(ChatErrorState(error: e.toString()));
    }
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    String userId = await _storage.read(key: "userId") ?? "";
    if (kDebugMode) {
      print("userId: $userId");
    }
    final newMessage = {
      "conversationId": event.conversationId,
      "content": event.content,
      "senderId": userId,
    };
    _socketService.socket.emit("sendMessage", newMessage);
  }

  Future<void> _onReceiveMessage(
    ReceiveMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    final recMessage = MessageEntity(
      id: event.message['id'],
      conversationId: event.message['conversation_id'],
      senderId: event.message['sender_id'],
      content: event.message['content'],
      createdAt: event.message['created_at'],
    );
    _messages.add(recMessage);
    emit(ChatLoadedState(List.from(_messages)));
  }
}
