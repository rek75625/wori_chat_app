import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:whatsapp_clone_py/features/domain/usecases/login_user_case.dart';
import 'package:whatsapp_clone_py/features/domain/usecases/register_use_case.dart';
import 'package:whatsapp_clone_py/features/presentation/bloc/auth_event.dart';
import 'package:whatsapp_clone_py/features/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final FlutterSecureStorage? _storage;

  AuthBloc({
    required this.registerUseCase,
    required this.loginUseCase,
    this._storage,
  }) : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await registerUseCase.registerCall(
        event.username,
        event.email,
        event.password,
      );

      emit(AuthSuccess(message: "Registration Succesful"));
    } catch (e) {
      emit(AuthFailure(error: "User failed to register"));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase.loginCall(event.email, event.password);
      await _storage!.write(key: 'token', value: user.token);
      emit(AuthSuccess(message: "Login Succesful"));
    } catch (e) {
      emit(AuthFailure(error: "User failed to login"));
    }
  }
}
