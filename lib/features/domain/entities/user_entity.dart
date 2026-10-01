class UserEntity {
  final String id;
  final String name;
  final String email;
  final String?
  token; // Fixed: Made nullable with '?' because registration has no token

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.token, // Removed required fallback assignment
  });
}
