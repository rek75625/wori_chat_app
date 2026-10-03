import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:whatsapp_clone_py/constants/theme.dart';
import 'package:whatsapp_clone_py/features/conversations/data/datasources/remote_conversation_source.dart';
import 'package:whatsapp_clone_py/features/conversations/data/repositories/conversation_repo_impl.dart';
import 'package:whatsapp_clone_py/features/conversations/domain/repositories/conversation_repo.dart';
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

void main() {
  final authRepositoryResigterLogin = AuthRepositoryResigterLogin(
    authRemoteDataSource: AuthRemoteDataSource(),
  );
  final conversationRepoImpl = ConversationRepoImpl(
    remoteConversationSource: RemoteConversationSource(),
  );
  runApp(
    MyApp(
      authRepositoryResigterLogin: authRepositoryResigterLogin,
      repository: conversationRepoImpl,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepositoryResigterLogin authRepositoryResigterLogin;
  final ConversationRepository repository;
  const MyApp({
    super.key,
    required this.authRepositoryResigterLogin,
    required this.repository,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
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
          create: (context) => ConversationsBloc(
            fetchConversationUsecase: FetchConversationUsecase(repository),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Wori ChatApp',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,

        home: ConversationsPage(),
        routes: {
          "/login": (_) => LoginPage(),
          "/register": (_) => RegisterPage(),
          "/conversations": (_) => ConversationsPage(),
        },
      ),
    );
  }
}
