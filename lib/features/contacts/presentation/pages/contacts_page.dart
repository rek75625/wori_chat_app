import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_py/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:whatsapp_clone_py/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:whatsapp_clone_py/features/contacts/presentation/bloc/contacts_state.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ContactsBloc>().add(FetchContactsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // FIX: Changed BlocBuilder to BlocConsumer to listen to non-visual side-effects
      body: BlocConsumer<ContactsBloc, ContactsState>(
        listener: (context, state) {
          if (state is ContactsAddedState) {
            // Show successful confirmation snackbar automatically
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Contact added successfully!"),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is ContactsErrorState) {
            // Show error message if duplicate, non-existent, or self-addition
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        buildWhen: (previous, current) {
          // Only re-build list UI layout if we hit specific visual structural states
          return current is ContactsLoadingState ||
              current is ContactsLoadedState ||
              current is ContactsErrorState;
        },
        builder: (context, state) {
          if (state is ContactsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ContactsLoadedState) {
            if (state.contacts.isEmpty) {
              return const Center(
                child: Text(
                  "Your contact list is empty.\nTry adding a registered user's email!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              itemCount: state.contacts.length,
              itemBuilder: (context, index) {
                final contact = state.contacts[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        contact.username.isNotEmpty
                            ? contact.username[0].toUpperCase()
                            : "?",
                      ),
                    ),
                    title: Text(
                      contact.username,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      contact.email,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: const Icon(Icons.chat, color: Colors.green),
                    onTap: () {
                      Navigator.pop(context, contact);
                    },
                  ),
                );
              },
            );
          }

          // Fallback UI view safe tracking handles
          return const Center(child: Text("Load contacts to start chat."));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddContactDialog,
        child: const Icon(Icons.person_add),
      ),
    );
  }

  Future<void> _showAddContactDialog() async {
    final emailController = TextEditingController();
    final contactsBloc = context.read<ContactsBloc>();

    try {
      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: const Text(
              "Add Contact",
              style: TextStyle(color: Colors.white),
            ),
            content: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Enter contact email",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final email = emailController.text.trim();

                  if (email.isEmpty) {
                    // FIX: Use general context to avoid popping a SnackBar on a dead dialog reference tree
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter an email address"),
                      ),
                    );
                    return;
                  }

                  final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                  if (!emailRegex.hasMatch(email)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter a valid email address"),
                      ),
                    );
                    return;
                  }

                  contactsBloc.add(AddContactsEvent(email: email));
                  Navigator.pop(dialogContext);
                },
                child: const Text("Add", style: TextStyle(color: Colors.blue)),
              ),
            ],
          );
        },
      );
    } finally {
      emailController.dispose();
    }
  }
}
