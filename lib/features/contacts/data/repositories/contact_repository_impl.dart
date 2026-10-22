import 'package:whatsapp_clone_py/features/contacts/data/datasource/contact_remote_data_source.dart';
import 'package:whatsapp_clone_py/features/contacts/domain/entities/contact_entity.dart';
import 'package:whatsapp_clone_py/features/contacts/domain/repositories/contacts_repository.dart';

class ContactRepositoryImpl implements ContactsRepository {
  final ContactRemoteDataSource contactRemoteDataSource;

  ContactRepositoryImpl({required this.contactRemoteDataSource});

  @override
  Future<void> addContacts({required String email}) async {
    try {
      await contactRemoteDataSource.addContacts(email: email);
    } catch (e) {
      // Catch the network/server error and throw a clear message
      throw Exception("Failed to sync contact addition to server: $e");
    }
  }

  @override
  Future<List<ContactEntity>> fetchContacts() async {
    try {
      return await contactRemoteDataSource.fetchContacts();
    } catch (e) {
      // Return an empty list or throw a custom error instead of crashing the app
      throw Exception(
        "Failed to load your phonebook contacts from database: $e",
      );
    }
  }

  @override
  Future<List<ContactEntity>> getRecentContacts() async {
    try {
      return await contactRemoteDataSource.fetchRecentContacts();
    } catch (e) {
      // Return an empty list or throw a custom error instead of crashing the app
      throw Exception(
        "Failed to load your phonebook contacts from database: $e",
      );
    }
  }
}
