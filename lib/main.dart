import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:whatsapp_clone_py/constants/theme.dart';
import 'package:whatsapp_clone_py/features/data/datasources/auth_remote_data_source.dart';
import 'package:whatsapp_clone_py/features/data/repositories/auth_repository_resigter_login.dart';
import 'package:whatsapp_clone_py/features/domain/usecases/login_user_case.dart';
import 'package:whatsapp_clone_py/features/domain/usecases/register_use_case.dart';
import 'package:whatsapp_clone_py/features/presentation/bloc/auth_bloc.dart';
import 'package:whatsapp_clone_py/features/presentation/pages/chat_page.dart';
import 'package:whatsapp_clone_py/features/presentation/pages/login_page.dart';
import 'package:whatsapp_clone_py/features/presentation/pages/register_page.dart';

void main() {
  final authRepositoryResigterLogin = AuthRepositoryResigterLogin(
    authRemoteDataSource: AuthRemoteDataSource(),
  );
  runApp(MyApp(authRepositoryResigterLogin: authRepositoryResigterLogin));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryResigterLogin authRepositoryResigterLogin;
  const MyApp({super.key, required this.authRepositoryResigterLogin});

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
      ],
      child: MaterialApp(
        title: 'Chat App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,

        home: RegisterPage(),
        routes: {
          "/login": (_) => LoginPage(),
          "/register": (_) => RegisterPage(),
          "/chatpage": (_) => ChatPage(),
        },
      ),
    );
  }
}
