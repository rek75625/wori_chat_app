import 'package:whatsapp_clone_py/features/contacts/data/datasource/contact_remote_data_source.dart';
import 'package:whatsapp_clone_py/features/contacts/domain/entities/contact_entity.dart';
import 'package:whatsapp_clone_py/features/contacts/domain/repositories/contacts_repository.dart';

class ContactRepositoryImpl implements ContactsRepository {
  final ContactRemoteDataSource contactRemoteDataSource;

  ContactRepositoryImpl({required this.contactRemoteDataSource});

  @override
  Future<void> addContacts({required String email}) async {
    await contactRemoteDataSource.addContacts(email: email);
  }

  @override
  Future<List<ContactEntity>> fetchContacts() async {
    return await contactRemoteDataSource.fetchContacts();
  }
}
