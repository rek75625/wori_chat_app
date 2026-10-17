import 'package:whatsapp_clone_py/features/contacts/domain/repositories/contacts_repository.dart';

class AddContactsUsecase {
  final ContactsRepository contactsRepository;

  const AddContactsUsecase({required this.contactsRepository});

  Future<void> callToAddContacts({required String email}) async {
    await contactsRepository.addContacts(email: email);
  }
}
