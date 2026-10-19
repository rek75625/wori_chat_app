import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:whatsapp_clone_py/constants/socket_service.dart';
import 'package:whatsapp_clone_py/constants/theme.dart';

import 'package:whatsapp_clone_py/features/chats/data/datasource/messages_remote_data_source.dart';
import 'package:whatsapp_clone_py/features/chats/data/repository/message_repo_impl.dart';
import 'package:whatsapp_clone_py/features/chats/domain/usecases/fetch_message_usecase.dart';
import 'package:whatsapp_clone_py/features/chats/presentation/bloc/chat_bloc.dart';

import 'package:whatsapp_clone_py/features/contacts/data/datasource/contact_remote_data_source.dart';
import 'package:whatsapp_clone_py/features/contacts/data/repositories/contact_repository_impl.dart';
import 'package:whatsapp_clone_py/features/contacts/domain/usecases/add_contacts_usecase.dart';
import 'package:whatsapp_clone_py/features/contacts/domain/usecases/fetch_contacts_usecase.dart';
import 'package:whatsapp_clone_py/features/contacts/presentation/bloc/contacts_bloc.dart';

import 'package:whatsapp_clone_py/features/conversations/data/datasources/remote_conversation_source.dart';
import 'package:whatsapp_clone_py/features/conversations/data/repositories/conversation_repo_impl.dart';
import 'package:whatsapp_clone_py/features/conversations/domain/usecases/check_or_create_conversation_usecase.dart';
import 'package:whatsapp_clone_py/features/conversations/domain/usecases/conversation_usecase.dart';
import 'package:whatsapp_clone_py/features/conversations/presentation/bloc/conversations_bloc.dart';
import 'package:whatsapp_clone_py/features/conversations/presentation/pages/conversations_page.dart';

import 'package:whatsapp_clone_py/features/data/datasources/auth_remote_data_source.dart';
import 'package:whatsapp_clone_py/features/data/repositories/auth_repository_resigter_login.dart';
import 'package:whatsapp_clone_py/features/domain/usecases/login_user_case.dart';
import 'package:whatsapp_clone_py/features/domain/usecases/register_use_case.dart';
import 'package:whatsapp_clone_py/features/presentation/bloc/auth_bloc.dart';
import 'package:whatsapp_clone_py/features/presentation/pages/login_page.dart';
import 'package:whatsapp_clone_py/features/presentation/pages/register_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the socket service.
  // Ensure initialize() does not require a login token if called here.
  final socketService = SocketService();
  await socketService.initialize();

  // Authentication dependencies.
  final authRepository = AuthRepositoryResigterLogin(
    authRemoteDataSource: AuthRemoteDataSource(),
  );

  // Conversation dependencies.
  final conversationRepository = ConversationRepoImpl(
    remoteConversationSource: RemoteConversationSource(),
  );

  // Message dependencies.
  final messageRepository = MessageRepoImpl(
    messagesRemoteDataSource: MessagesRemoteDataSource(),
  );

  // Contact dependencies.
  final contactsRepository = ContactRepositoryImpl(
    contactRemoteDataSource: ContactRemoteDataSource(),
  );

  runApp(
    MyApp(
      authRepositoryResigterLogin: authRepository,
      coversationrepository: conversationRepository,
      messageRepository: messageRepository,
      contactsRepository: contactsRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepositoryResigterLogin authRepositoryResigterLogin;
  final ConversationRepoImpl coversationrepository;
  final MessageRepoImpl messageRepository;
  final ContactRepositoryImpl contactsRepository;

  const MyApp({
    super.key,
    required this.authRepositoryResigterLogin,
    required this.coversationrepository,
    required this.messageRepository,
    required this.contactsRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            registerUseCase: RegisterUseCase(
              authRepository: authRepositoryResigterLogin,
            ),
            loginUseCase: LoginUseCase(
              authRepository: authRepositoryResigterLogin,
            ),
            storage: const FlutterSecureStorage(),
          ),
        ),
        BlocProvider(
          create: (_) => ConversationsBloc(
            fetchConversationUsecase: FetchConversationUsecase(
              coversationrepository,
            ),
          ),
        ),
        BlocProvider(
          create: (_) => ChatBloc(
            fetchMessageUsecase: FetchMessageUsecase(
              messageRepository: messageRepository,
            ),
          ),
        ),
        BlocProvider(
          create: (_) => ContactsBloc(
            fetchContactsUsecase: FetchContactsUsecase(
              contactsRepository: contactsRepository,
            ),
            addContactsUsecase: AddContactsUsecase(
              contactsRepository: contactsRepository,
            ),
            conversationUseCase: CheckOrCreateConversationUseCase(
              conversationRepository: coversationrepository,
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Wori ChatApp',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const LoginPage(),
        routes: {
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
          '/conversationsPage': (_) => const ConversationsPage(),
        },
      ),
    );
  }
}
