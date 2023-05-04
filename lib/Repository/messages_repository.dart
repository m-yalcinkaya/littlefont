import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesRepository extends ChangeNotifier{


 List<Message> messages = [
   Message(
     text: 'Hi Mustafa!',
     isMe: false,
     time: DateTime.now(),
   ),
   Message(
     text: 'Hi Kemal!',
     isMe: true,
     time: DateTime.now(),
   ),
   Message(
     text: 'How are you!',
     isMe: false,
     time: DateTime.now(),
   ),
  Message(
    text: 'I\'m fine and you?',
    isMe: true,
    time: DateTime.now(),
  ),



];


 void addMessage(Message message, List list){
   list.add(message);
   notifyListeners();
 }

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
