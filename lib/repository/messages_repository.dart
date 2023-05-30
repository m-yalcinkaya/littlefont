import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/modals/message.dart';
import 'package:littlefont/services/message_service.dart';

class MessagesRepository extends ChangeNotifier {
  final MessageService dataService;

  MessagesRepository(this.dataService);

  List<Message> messages = [];
  List<DocumentSnapshot> chatListData = [];
  Map<String, dynamic> data = {};


  Future<void> sendMessage(String email, String message) async {
    try{
      await dataService.updateJson(email, message, true);
      await dataService.updateJson(email, message, false);
    }catch(e){
      throw Exception('Messages could not be sent \n$e');
    }
  }

}

final messageProvider = ChangeNotifierProvider((ref) {
  return MessagesRepository(ref.watch(messageServiceProvider));
});
