// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whatsapp_clone_py/features/chats/data/datasource/messages_remote_data_source.dart';
import 'package:whatsapp_clone_py/features/chats/data/repository/message_repo_impl.dart';
import 'package:whatsapp_clone_py/features/conversations/data/datasources/remote_conversation_source.dart';
import 'package:whatsapp_clone_py/features/conversations/data/repositories/conversation_repo_impl.dart';
import 'package:whatsapp_clone_py/features/data/datasources/auth_remote_data_source.dart';
import 'package:whatsapp_clone_py/features/data/repositories/auth_repository_resigter_login.dart';

import 'package:whatsapp_clone_py/main.dart';

void main() {
  final authRepositoryResigterLogin = AuthRepositoryResigterLogin(
    authRemoteDataSource: AuthRemoteDataSource(),
  );
  final conversationRepoImpl = ConversationRepoImpl(
    remoteConversationSource: RemoteConversationSource(),
  );
  final messageRepoImpl = MessageRepoImpl(
    messagesRemoteDataSource: MessagesRemoteDataSource(),
  );
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MyApp(
        authRepositoryResigterLogin: authRepositoryResigterLogin,
        repository: conversationRepoImpl,
        messageRepository: messageRepoImpl,
      ),
    );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
