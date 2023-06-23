import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/modals/message.dart';
import 'package:littlefont_app/services/message_service.dart';

class MessagesRepository extends ChangeNotifier {
  final MessageService dataService;

  MessagesRepository(this.dataService);

  List<Message> messages = [];
  List<Map<String, dynamic>> chatListData = [];
  Map<String, dynamic> data = {};


  Future<void> sendMessage(String email, String message) async {
    try{
      await dataService.updateJson(email, message, true);
      await dataService.updateJson(email, message, false);
    }catch(e){
      throw Exception('Messages could not be sent \n$e');
    }
  }


  Widget profilImage(String? photoUrl, {bool isBigPhoto = false}) {
    if (photoUrl != null && photoUrl.isNotEmpty) {
      return CircleAvatar(
        backgroundImage: NetworkImage(photoUrl),
        radius: isBigPhoto ? 20 : 16,
        backgroundColor: Colors.blue,
      );
    }else {
      return CircleAvatar(
        maxRadius: isBigPhoto ? 20 : 16,
        child: const Icon(Icons.person),
      );
    }
  }


}

final messageProvider = ChangeNotifierProvider((ref) {
  return MessagesRepository(ref.watch(messageServiceProvider));
});
