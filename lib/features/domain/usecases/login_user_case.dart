import 'package:whatsapp_clone_py/feature/domain/entities/user_entity.dart';
import 'package:whatsapp_clone_py/feature/domain/repositories/auth_repository.dart';

class RegisterUseCase {

  final AuthRepository authRepository;
  RegisterUseCase({required this.authRepository});
  Future<UserEntity> loginCall(String email, String password){
    return authRepository.login(email, password);
  }
}