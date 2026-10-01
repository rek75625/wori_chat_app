import 'package:whatsapp_clone_py/features/domain/entities/user_entity.dart';
import 'package:whatsapp_clone_py/features/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;
  RegisterUseCase({required this.authRepository});
  Future<UserEntity> registerCall(
    String username,
    String email,
    String password,
  ) {
    return authRepository.register(username, email, password);
  }
}
