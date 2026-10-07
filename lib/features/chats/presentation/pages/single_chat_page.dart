import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:whatsapp_clone_py/constants/app_sizing.dart';
import 'package:whatsapp_clone_py/constants/colors.dart';
import 'package:whatsapp_clone_py/features/chats/presentation/bloc/chat_bloc.dart';
import 'package:whatsapp_clone_py/features/chats/presentation/bloc/chat_event.dart';

class ChatPage extends StatefulWidget {
  final String conversationId;
  const ChatPage({super.key, required this.conversationId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final _storage = FlutterSecureStorage();
  String userId = "";

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatBloc>(context)
        .add(LoadMessagesEvent(conversationId: widget.conversationId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Row(
          children: [
            // Avatar
            const CircleAvatar(radius: 25, backgroundColor: Color(0xFFD6E7F8)),
            const SizedBox(width: 12),
            Text("AnyOne", style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: AppSizes.padAll24,
              children: [
                _buildReceivedMessage(context, "Welcome to messages"),
                _buildSentMessage(context, "Thank you"),
                _buildReceivedMessage(context, "Welcome to messages"),
                _buildSentMessage(context, "Thank you"),
                _buildReceivedMessage(context, "Welcome to messages"),
                _buildSentMessage(context, "Thank you"),
              ],
            ),
          ),
          _buildMessageInput(context),
        ],
      ),
    );
  }

  Widget _buildReceivedMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(right: 30, top: 5, bottom: 5),
        padding: AppSizes.padAll16,
        decoration: BoxDecoration(
          color: DefaultColors.receiverMessage,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }

  Widget _buildSentMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(left: 30, top: 5, bottom: 5),
        padding: AppSizes.padAll16,
        decoration: BoxDecoration(
          color: DefaultColors.senderMessage,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      margin: AppSizes.padAll24,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: DefaultColors.sentMessageInput,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.camera_alt, color: Colors.grey),
          ),
          AppSizes.width12,
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Type here .....",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.grey),
            ),
          ),
          AppSizes.height8,
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.send, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
