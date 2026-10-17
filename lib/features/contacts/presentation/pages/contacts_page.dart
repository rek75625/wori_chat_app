import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_py/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:whatsapp_clone_py/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:whatsapp_clone_py/features/contacts/presentation/bloc/contacts_state.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<ContactsBloc, ContactsState>(
        builder: (context, state) {
          if (state is ContactsLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ContactsLoadedState) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.contacts.length,
              itemBuilder: (context, index) {
                final contact = state.contacts[index];
                return ListTile(
                  title: Text(contact.username),
                  subtitle: Text(contact.email),
                  onTap: () {
                    Navigator.pop(context, contact);
                  },
                );
              },
            );
          } else if (state is ContactsErrorState) {
            return Center(child: Text("Something went wrong"));
          }
          return Center(child: Text("Contacts Not Found"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(context),
        child: Text("Add"),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    final emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Contact"),
        content: TextFormField(
          controller: emailController,

          decoration: InputDecoration(hintText: "Enter contac email"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final email = emailController.text.trim();
              if (email.isNotEmpty) {
                BlocProvider.of<ContactsBloc>(context)
                    .add(AddContactsEvent(email: email));
                Navigator.pop(context);
              }
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }
}
