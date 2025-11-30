import 'dart:convert';
import 'package:gmsflutter/entity/chat_entity/chat_message.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatService {
  final String baseUrl = "http://localhost:8080/api/messages";

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("authToken");
  }

  // Get all messages
  Future<List<ChatMessage>> getMessages() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => ChatMessage.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load messages");
    }
  }

  // Send a message (role as sender)
  Future<ChatMessage> sendMessage(ChatMessage message) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
      body: jsonEncode(message.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ChatMessage.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to send message");
    }
  }
}
