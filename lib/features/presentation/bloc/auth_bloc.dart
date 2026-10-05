import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:whatsapp_clone_py/features/domain/usecases/login_user_case.dart';
import 'package:whatsapp_clone_py/features/domain/usecases/register_use_case.dart';
import 'package:whatsapp_clone_py/features/presentation/bloc/auth_event.dart';
import 'package:whatsapp_clone_py/features/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final FlutterSecureStorage
  _storage; // Fixed: Removed the '?' to make it strictly non-nullable

  AuthBloc({
    required this.registerUseCase,
    required this.loginUseCase,
    required this._storage, // Fixed: Added 'required' keyword here
  }) : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Safely calls the remote data source mapping
      await registerUseCase.registerCall(
        event.username,
        event.email,
        event.password,
      );

      emit(AuthSuccess(message: "Registration Successful"));
    } catch (e) {
      emit(AuthFailure(error: "User failed to register"));
      log("Register Error: ${e.toString()}");
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase.loginCall(event.email, event.password);

      // Safe to write now because _storage cannot be null
      await _storage.write(key: 'token', value: user.token ?? '');

      emit(AuthSuccess(message: "Login Successful"));
    } catch (e) {
      emit(AuthFailure(error: "User failed to login"));
      log("Login Error: ${e.toString()}");
    }
  }
}
