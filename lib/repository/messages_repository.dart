import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/modals/message.dart';
import 'package:littlefont/services/message_service.dart';

class MessagesRepository extends ChangeNotifier {
  final MessageService dataService;

  MessagesRepository(this.dataService);

  List<Message> messages = [Message(text: 'Message', isMe: false)];

  Future<void> download() async {
    Message message = await dataService.getMessage();
    messages.add(message);
    notifyListeners();
  }
  Future<void> downloadAsList() async {
    final result = await dataService.getMessageFromList();
    messages.addAll(result);
    notifyListeners();
  }

  Future<void> sendMessage(Message message) async {
    final result = await dataService.sendMessage(message);
    messages = [];
    messages.addAll(result);
    notifyListeners();
  }

  void addMessage(Message message, List list) {
    list.add(message);
    notifyListeners();
  }
}

final messageProvider = ChangeNotifierProvider((ref) {
  return MessagesRepository(ref.watch(messageServiceProvider));
});
