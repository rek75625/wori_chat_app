import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:whatsapp_clone_py/constants/app_sizing.dart';
import 'package:whatsapp_clone_py/constants/colors.dart';
import 'package:whatsapp_clone_py/features/chats/presentation/bloc/chat_bloc.dart';
import 'package:whatsapp_clone_py/features/chats/presentation/bloc/chat_event.dart';
import 'package:whatsapp_clone_py/features/chats/presentation/bloc/chat_state.dart';

class ChatPage extends StatefulWidget {
  final String conversationId;
  final String mate;
  final String profileImage;

  const ChatPage({
    super.key,
    required this.conversationId,
    required this.mate,
    required this.profileImage,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String userId = "";
  String botId = "00000000-0000-0000-0000-000000000000";

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final id = await _storage.read(key: 'userId');

    if (!mounted) return;

    setState(() {
      userId = id ?? '';
    });

    if (!mounted) return;

    context.read<ChatBloc>().add(
      LoadMessagesEvent(conversationId: widget.conversationId),
    );
    context.read<ChatBloc>().add(
      LoadDailyQuestionsEvent(conversationId: widget.conversationId),
    );
  }

  void sendMessage() {
    final content = _messageController.text.trim();

    if (content.isEmpty) return;

    context.read<ChatBloc>().add(
      SendMessageEvent(conversationId: widget.conversationId, content: content),
    );

    _messageController.clear();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 1. Completely hide the default framework back arrow override
        automaticallyImplyLeading: false,
        backgroundColor: DefaultColors.messageListPage,
        elevation: 0,

        // 2. Put the action arrow in its dedicated semantic slot
        leading: IconButton(
          onPressed: () {
            // Instantly pops the current screen context and navigates backward safely
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),

        // 3. Move the profile layout information cleanly into the title widget
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar
            CircleAvatar(
              radius: 20, // Slightly resized to look balanced inside standard AppBar heights
              backgroundColor: Color(0xFFD6E7F8),
              backgroundImage: NetworkImage(widget.profileImage),
            ),
            const SizedBox(width: 12),

            // Participant Profile Name
            Expanded(
              child: Text(
                widget.mate,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  overflow: TextOverflow.ellipsis, // Prevents text crashing into search icon if name is long
                ),
              ),
            ),
          ],
        ),

        // 4. Actions remain securely positioned on the right-hand layout margin
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.grey),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ChatLoadedState) {
                  final messages = state.messages;
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isSentByUser =
                          message.senderId.toString() == userId;
                      final isDailyQuestion =
                          message.senderId.toString() == botId;
                      return isSentByUser
                          ? _buildSentMessage(context, message.content)
                          : isDailyQuestion
                          ? _buildDailyQuestionsMessage(
                              context,
                              message.content,
                            )
                          : _buildReceivedMessage(context, message.content);
                    },
                  );
                } else if (state is ChatErrorState) {
                  return Center(child: Text("Error: ${state.error}"));
                } else {
                  return Center(child: Text("Unknown state"));
                }
              },
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
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type here .....",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.grey),
              onFieldSubmitted: (value) {
                if (value.isNotEmpty) {
                  sendMessage();
                }
              },
            ),
          ),
          AppSizes.height8,
          GestureDetector(
            onTap: sendMessage,
            child: Icon(Icons.send, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyQuestionsMessage(BuildContext context, String content) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(right: 30, top: 5, bottom: 5),
        padding: AppSizes.padAll16,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Text(
          "🧠 Daily Questions : $content",
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: Colors.white70),
        ),
      ),
    );
  }
}
