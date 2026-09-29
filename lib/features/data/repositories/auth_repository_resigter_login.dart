import 'package:whatsapp_clone_py/features/data/datasources/auth_remote_data_source.dart';
import 'package:whatsapp_clone_py/features/domain/entities/user_entity.dart';
import 'package:whatsapp_clone_py/features/domain/repositories/auth_repository.dart';

class AuthRepositoryResigterLogin implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  new({required this.authRemoteDataSource});
  @override
  Future<UserEntity> login(String email, String password) async {
   return await authRemoteDataSource.login(email: email, password: password);
  }

  @override
  Future<UserEntity> register(String username, String email, String password) async {
  return await authRemoteDataSource.resgister(username: username, email: email, password: password);
  }
}