import 'package:whatsapp_clone_py/features/contacts/domain/entities/contact_entity.dart';
import 'package:whatsapp_clone_py/features/contacts/domain/repositories/contacts_repository.dart';

class RecentContactUsecase {
  final ContactsRepository contactsRepository;

  RecentContactUsecase({required this.contactsRepository});

  Future<List<ContactEntity>> callGetRecentContacts()async{
    return await contactsRepository.getRecentContacts();
  }
}
