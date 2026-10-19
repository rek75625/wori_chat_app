abstract class ContactsEvent {
  const ContactsEvent();
}

class FetchContactsEvent extends ContactsEvent {
  const FetchContactsEvent();
}

class CheckOrCreateCoversationEvent extends ContactsEvent {
  final String contactId;
  final String contactName;
  const CheckOrCreateCoversationEvent({
    required this.contactId,
    required this.contactName,
  });
}

class AddContactsEvent extends ContactsEvent {
  final String email;

  const AddContactsEvent({required this.email});
}
