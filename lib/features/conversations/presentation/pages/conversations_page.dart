import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_py/constants/app_sizing.dart';
import 'package:whatsapp_clone_py/constants/colors.dart';
import 'package:whatsapp_clone_py/features/conversations/presentation/bloc/conversations_bloc.dart';
import 'package:whatsapp_clone_py/features/conversations/presentation/bloc/conversations_event.dart';
import 'package:whatsapp_clone_py/features/conversations/presentation/bloc/conversations_state.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key});

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ConversationsBloc>(context).add(GetConversationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111827),
        elevation: 0,
        title: const Text(
          'Messages',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Recent",
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: Colors.white60),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height:
                90, // Increased slightly to prevent any potential text clipping
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _statusTile(name: "Berry"),
                _statusTile(name: "Verry"),
                _statusTile(name: "Gerry"),
                _statusTile(name: "Jerry"),
                _statusTile(name: "Aerry"),
                _statusTile(name: "Merry"),
                _statusTile(name: "Perry"),
              ],
            ),
          ),

          AppSizes.height24,

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: DefaultColors.messageListPage,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: BlocBuilder<ConversationsBloc, ConversationsState>(
                builder: (context, state) {
                  if (state is ConversationsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ConversationsLoaded) {
                    if (state.conversations.isEmpty) {
                      return const Center(
                        child: Text(
                          "No conversations found",
                          style: TextStyle(color: Colors.white70),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.conversations.length,
                      itemBuilder: (context, index) {
                        final conversation = state.conversations[index];
                        return _messageTile(
                          name: conversation.participantName,
                          message: conversation.lastMessage,
                          time: conversation.lastMessageTime.toString(),
                        );
                      },
                    );
                  } else if (state is ConversationsError) {
                    return const Center(
                      child: Text(
                        "Something went wrong",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    );
                  }
                  return const Center(
                    child: Text(
                      "No conversations found",
                      style: TextStyle(color: Colors.white70),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _messageTile({
    required String name,
    required String message,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: const CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xFFD6E7F8),
        ),
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          message,
          maxLines: 1,
          overflow: TextOverflow
              .ellipsis, // Prevents text crashing out if message is too long
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
        trailing: Text(
          time,
          style: const TextStyle(color: Colors.white38, fontSize: 10),
        ),
      ),
    );
  }

  Widget _statusTile({required String name}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Takes up only required space
        children: [
          const CircleAvatar(radius: 25, backgroundColor: Color(0xFFD6E7F8)),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
