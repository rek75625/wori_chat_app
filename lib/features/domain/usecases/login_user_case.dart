import 'package:whatsapp_clone_py/features/domain/entities/user_entity.dart';
import 'package:whatsapp_clone_py/features/domain/repositories/auth_repository.dart';

class LoginUseCase {

  final AuthRepository authRepository;
  LoginUseCase({required this.authRepository});
  Future<UserEntity> loginCall(String email, String password){
    return authRepository.login(email, password);
  }
}