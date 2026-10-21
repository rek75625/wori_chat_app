import 'package:whatsapp_clone_py/features/contacts/domain/entities/contact_entity.dart';

class ContactModel extends ContactEntity {
  ContactModel({
    required super.id,
    required super.username,
    required super.email,
    required super.profileImage,
  });
  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['contact_id'],
      username: map['username'],
      email: map['email'],
      profileImage: map['profile_image'],
    );
  }
}
