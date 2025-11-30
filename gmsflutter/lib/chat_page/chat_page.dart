import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/chat_entity/chat_message.dart';
import 'package:gmsflutter/service/chat_service/chat_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService _chatService = ChatService();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<ChatMessage> messages = [];
  String currentUserRole = "";
  bool isLoading = true;

  // --- Aesthetic Color Palette ---
  static const Color chatBackgroundColor = Color(0xFFFBFBFB); // Soft Off-White
  static const Color primaryColor = Color(0xFF6A1B9A); // Deep Purple (App Bar, Send Button)
  static const Color accentColor = Color(0xFFE0F7FA); // Very Light Cyan (Received Bubbles)
  static const Color myBubbleColor = Color(0xFFC8E6C9); // Light Muted Green (Sent Bubbles)
  static const Color senderNameColor = Color(0xFF424242);
  static const Color messageTextColor = Color(0xFF212121);
  static const Color timeStampColor = Color(0xFF757575);
  static const Color inputBackgroundColor = Color(0xFFEFEFEF); // Light Grey for input field

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
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
    _scrollToBottom();
  }

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final newMessage = ChatMessage(
      sender: currentUserRole,
      content: _controller.text,
      timestamp: DateTime.now(),
    );

    final savedMessage = await _chatService.sendMessage(newMessage);

    setState(() {
      messages.add(savedMessage);
    });

    _controller.clear();
    _scrollToBottom();
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
        title: Text(
          "Chat – $currentUserRole",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 4,
      ),
      body: Container(
        // --- Solid Off-White Background ---
        color: chatBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: messages.isEmpty
                  ? Center(
                child: Text(
                  "No messages yet. Start chatting!",
                  style: TextStyle(
                    fontSize: 16,
                    color: timeStampColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
                  : ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 10.0),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  final isMe = msg.sender == currentUserRole;
                  return _buildMessageBubble(msg, isMe);
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  // --- Message Bubble Widget ---
  Widget _buildMessageBubble(ChatMessage msg, bool isMe) {
    final bubbleColor = isMe ? myBubbleColor : accentColor;
    final textColor = messageTextColor;
    final timeColor = timeStampColor;

    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
      bottomLeft: isMe ? const Radius.circular(20) : const Radius.circular(6),
      bottomRight: isMe ? const Radius.circular(6) : const Radius.circular(20),
    );

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe)
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  msg.sender,
                  style: TextStyle(
                    color: senderNameColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            Text(
              msg.content,
              style: TextStyle(color: textColor, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                DateFormat('h:mm a').format(msg.timestamp.toLocal()),
                style: TextStyle(
                  fontSize: 11,
                  color: timeStampColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Message Input Widget ---
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      color: Colors.white, // Input bar remains bright white for clarity
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextField(
                controller: _controller,
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: "Type your message...",
                  hintStyle: TextStyle(color: timeStampColor),
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: inputBackgroundColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: primaryColor.withOpacity(0.5), width: 1),
                  ),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          // --- Floating Action Button for Send ---
          FloatingActionButton(
            onPressed: _sendMessage,
            backgroundColor: primaryColor,
            elevation: 4,
            mini: false,
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}