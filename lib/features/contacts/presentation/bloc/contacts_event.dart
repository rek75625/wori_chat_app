abstract class ContactsEvent {
  const ContactsEvent();
}

class FetchContactsEvent extends ContactsEvent {
  const FetchContactsEvent();
}

class AddContactsEvent extends ContactsEvent {
  final String email;

  const AddContactsEvent({required this.email});
}
