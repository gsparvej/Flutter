import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/chat_entity/chat_message.dart';
import 'package:gmsflutter/service/chat_service/chat_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService _chatService = ChatService();
  final TextEditingController _controller = TextEditingController();

  List<ChatMessage> messages = [];
  String currentUserRole = ""; // role will be stored here
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? role = prefs.getString('userRole');

    setState(() {
      currentUserRole = role ?? '';
      isLoading = false;
    });

    _loadMessages();
  }

  void _loadMessages() async {
    final data = await _chatService.getMessages();
    setState(() {
      messages = data;
    });
  }

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final newMessage = ChatMessage(
      sender: currentUserRole, // ✅ role as sender
      content: _controller.text,
      timestamp: DateTime.now(),
    );

    final savedMessage = await _chatService.sendMessage(newMessage);

    setState(() {
      messages.add(savedMessage);
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat – $currentUserRole"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? const Center(child: Text("No messages yet"))
                : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isMe = msg.sender == currentUserRole;

                return Align(
                  alignment: isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin:
                    const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border:
                      Border.all(color: Colors.grey.shade300),
                    ),
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg.sender, // role shown
                          style: TextStyle(
                            color: isMe
                                ? Colors.white70
                                : Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          msg.content,
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${msg.timestamp.hour}:${msg.timestamp.minute.toString().padLeft(2,'0')}",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 10,
                            color: isMe
                                ? Colors.white70
                                : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
