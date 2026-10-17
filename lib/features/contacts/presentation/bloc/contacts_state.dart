import 'package:whatsapp_clone_py/features/contacts/domain/entities/contact_entity.dart';

abstract class ContactsState {}

class ContactsInitialState extends ContactsState {}

class ContactsLoadingState extends ContactsState {}

class ContactsLoadedState extends ContactsState {
  final List<ContactEntity> contacts;

  ContactsLoadedState({required this.contacts});
}

class ContactsErrorState extends ContactsState {
  final String message;

  ContactsErrorState({required this.message});
}

class ContactsAddedState extends ContactsState {}
