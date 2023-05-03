
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesRepository extends ChangeNotifier{

/*
final List<Message> _messages = [
    Message(
      text: 'Hi there!',
      isMe: false,
      time: DateTime.now(),
    ),
    Message(
      text: 'Hello!',
      isMe: true,
      time: DateTime.now(),
    ),
    Message(
      text: 'How are you?',
      isMe: false,
      time: DateTime.now(),
    ),

  ];
*/


bool isNavBarVisible = true;
}


final messageProvider = ChangeNotifierProvider((ref) {
  return MessagesRepository();
});



class Message {
  final String text;
  final bool isMe;
  final DateTime time;

  Message({required this.text, required this.isMe, required this.time});
}
