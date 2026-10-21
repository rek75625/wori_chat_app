import 'package:whatsapp_clone_py/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.token,
    required super.profileImage,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      // Fixed: Map 'username' from the backend payload, fallback to empty string if missing
      name: map['username'] ?? map['name'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? "",
      profileImage: map['profile_mage'] ?? "https://placehold.co/600x400/png",
    );
  }
}
