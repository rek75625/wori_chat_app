import 'package:whatsapp_clone_py/features/contacts/domain/entities/contact_entity.dart';
import 'package:whatsapp_clone_py/features/contacts/domain/repositories/contacts_repository.dart';

class FetchContactsUsecase {
  final ContactsRepository contactsRepository;

  FetchContactsUsecase({required this.contactsRepository});

  // Changing this to 'call' allows functional invocation shortcuts
  Future<List<ContactEntity>> call() async {
    return await contactsRepository.fetchContacts();
  }
}
