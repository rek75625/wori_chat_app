import 'package:whatsapp_clone_py/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
  });

 factory UserModel.fromMap(Map<String,dynamic> map){
    return UserModel(
      id:map['id'] ,
     name: map['name'],
      email: map['email']);
  }

}