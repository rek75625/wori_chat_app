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

      // 1. CLEAR ANY OLD EVENTS FIRST TO PREVENT MULTIPLE RESUBMISSIONS
      _socketService.socket.off('receive_message');

      // 2. Now join the room safely
      _socketService.socket.emit('join_room', event.conversationId);

      // 3. Register the clean listener
      _socketService.socket.on('receive_message', (data) {
        if (!isClosed) {
          add(ReceiveMessageEvent(message: data));
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
    final userId = await _storage.read(key: 'userId');

    if (userId == null || userId.isEmpty) {
      debugPrint('Error: userId is missing.');
      return;
    }

    final newMessage = {
      'conversationId': event.conversationId,
      'senderId': userId,
      'content': event.content,
    };

    debugPrint('Sending message: $newMessage');

    _socketService.socket.emit('send_message', newMessage);
  }

  Future<void> _onReceiveMessage(
    ReceiveMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    // Safety check: Prevent emitting state if the Bloc or widget screen is closed
    if (isClosed) return;

    try {
      final rawDate = event.message['created_at'];
      DateTime parsedDate;

      if (rawDate is DateTime) {
        parsedDate = rawDate;
      } else if (rawDate is String) {
        parsedDate = DateTime.parse(rawDate);
      } else {
        parsedDate = DateTime.now();
      }

      final recMessage = MessageEntity(
        id: event.message['id']?.toString() ?? '',
        conversationId: event.message['conversation_id']?.toString() ?? '',
        senderId: event.message['sender_id']?.toString() ?? '',
        content: event.message['content']?.toString() ?? '',
        createdAt: parsedDate,
      );

      _messages.add(recMessage);
      emit(ChatLoadedState(List.from(_messages)));
    } catch (e) {
      debugPrint("Error parsing incoming message data: $e");
    }
  }

  // ✅ Clean up socket listeners when user leaves the chat page
  @override
  Future<void> close() {
    _socketService.socket.off('receive_message');
    return super.close();
  }
}
