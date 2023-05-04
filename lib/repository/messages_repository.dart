import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/modals/message.dart';

class MessagesRepository extends ChangeNotifier {
  List<Message> messages = [
    Message(
      text: 'Hi Mustafa!',
      isMe: false,
    ),
    Message(
      text: 'Hi Kemal!',
      isMe: true,
    ),
    Message(
      text: 'How are you!',
      isMe: false,
    ),
    Message(
      text: 'I\'m fine and you?',
      isMe: true,
    ),
  ];

  void download() {
    const j = """{
  "text": "My name is Ali",
  "isMe": false
    }""";

    final m = jsonDecode(j);

    final mesaj = Message.fromJson(m);
    messages.add(mesaj);
    notifyListeners();
  }

  void addMessage(Message message, List list) {
    list.add(message);
    notifyListeners();
  }
}

final messageProvider = ChangeNotifierProvider((ref) {
  return MessagesRepository();
});
