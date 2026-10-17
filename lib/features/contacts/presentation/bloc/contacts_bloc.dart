import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:whatsapp_clone_py/features/contacts/domain/usecases/add_contacts_usecase.dart';
import 'package:whatsapp_clone_py/features/contacts/domain/usecases/fetch_contacts_usecase.dart';
import 'package:whatsapp_clone_py/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:whatsapp_clone_py/features/contacts/presentation/bloc/contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final FetchContactsUsecase fetchContactsUsecase;
  final AddContactsUsecase addContactsUsecase;

  ContactsBloc({
    required this.fetchContactsUsecase,
    required this.addContactsUsecase,
  }) : super(ContactsInitialState()) {
    on<FetchContactsEvent>(_onFetchContactsEvent);
    on<AddContactsEvent>(_onAddContactsEvent);
  }

  Future<void> _onFetchContactsEvent(
    FetchContactsEvent event,
    Emitter<ContactsState> emit,
  ) async {
    emit(ContactsLoadingState());

    try {
      final contacts = await fetchContactsUsecase.call();
      emit(ContactsLoadedState(contacts: contacts));
    } catch (e) {
      emit(ContactsErrorState(message: "Failed to fetch contacts: $e"));
    }
  }

  Future<void> _onAddContactsEvent(
    AddContactsEvent event,
    Emitter<ContactsState> emit,
  ) async {
    // 1. Show a loading state on the screen while talking to the backend node server
    emit(ContactsLoadingState());

    try {
      // 2. Perform the server write operation
      await addContactsUsecase.callToAddContacts(email: event.email);

      // 3. Tell the listener that it succeeded (this triggers the green SnackBar)
      emit(ContactsAddedState());

      // 4. THE FIX: Tell the bloc to cleanly fetch a fresh, updated list from scratch
      add(FetchContactsEvent());
    } catch (e) {
      emit(
        ContactsErrorState(message: e.toString().replaceAll("Exception: ", "")),
      );
    }
  }
}
