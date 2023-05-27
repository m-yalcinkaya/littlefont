import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/modals/message.dart';
import 'package:http/http.dart' as http;

class MessageService {

  final chats = FirebaseFirestore.instance.collection('${FirebaseAuth.instance.currentUser!.uid}/chats');

  final String baseUrl = 'https://6453fa27e9ac46cedf34d487.mockapi.io';

  Future<Message> getMessage() async {
    final response = await http.get(Uri.parse('$baseUrl/Message/1'));
    if (response.statusCode == 200) {
      return Message.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Message couldn\'t downloaded: ${response.statusCode}');
    }
  }

  Future<List<Message>> getMessageFromList() async {
    chats.get(

    );

    final response = await http.get(Uri.parse('$baseUrl/Message'));
    List<Message> messages = [];
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> a in result) {
        messages.add(Message.fromJson(a));
      }
      return messages;
    } else {
      throw Exception('Message couldn\'t downloaded: ${response.statusCode}');
    }
  }

  Future<List<Message>> sendMessage(Message message) async {

    final response = await http.post(
      Uri.parse('$baseUrl/Message'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{"text": message.text, "isMe": message.isMe}),
    );

    if (response.statusCode == 201) {
      return getMessageFromList();
    } else {
      throw Exception('Message couldn\'t downloaded: ${response.statusCode}');
    }
  }
}

final messageServiceProvider = Provider((ref) {
  return MessageService();
});
