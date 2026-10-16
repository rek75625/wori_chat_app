abstract class ContactsEvent {}

class FetchContactsEvent extends ContactsEvent {}

class AddContactsEvent extends ContactsEvent {
  final String email;

  AddContactsEvent({required this.email});
}
