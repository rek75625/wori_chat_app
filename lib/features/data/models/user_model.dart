import 'package:whatsapp_clone_py/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.token, // Fixed: Removed 'required' to allow it to pass null safely
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      // Fixed: Map 'username' from the backend payload, fallback to empty string if missing
      name: map['username'] ?? map['name'] ?? '',
      email: map['email'] ?? '',
      token:
          map['token'] ??
          "", // Safely accepts null or string now without throwing a type crash
    );
  }
}
