class UserEntity {
  final String id;
  final String name;
  final String email;
  final String? token;
  final String profileImage;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.token,
    required this.profileImage,
  });
}
