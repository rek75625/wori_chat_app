import 'package:whatsapp_clone_py/features/contacts/domain/entities/contact_entity.dart';

abstract class ContactsState {
  const ContactsState();
}

class ContactsInitialState extends ContactsState {
  const ContactsInitialState();
}

class ContactsLoadingState extends ContactsState {
  const ContactsLoadingState();
}

class ContactsLoadedState extends ContactsState {
  final List<ContactEntity> contacts;

  const ContactsLoadedState({required this.contacts});
}

class ContactsErrorState extends ContactsState {
  final String message;

  const ContactsErrorState({required this.message});
}

class ContactsAddedState extends ContactsState {
  const ContactsAddedState();
}
