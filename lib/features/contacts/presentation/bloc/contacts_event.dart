import 'package:whatsapp_clone_py/features/contacts/domain/entities/contact_entity.dart';

abstract class ContactsEvent {
  const ContactsEvent();
}

class FetchContactsEvent extends ContactsEvent {
  const FetchContactsEvent();
}

class CheckOrCreateCoversationEvent extends ContactsEvent {
  final String contactId;
  final ContactEntity contact;
  const CheckOrCreateCoversationEvent({
    required this.contactId,
    required this.contact,
  });
}

class AddContactsEvent extends ContactsEvent {
  final String email;

  const AddContactsEvent({required this.email});
}
