import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../repository/messages_repository.dart';
import '../services/message_service.dart';

class LastMessageWidget extends ConsumerWidget {
  const LastMessageWidget({
    super.key,
  });


  String controlledLastMessage(String lastMessage){
    if(lastMessage.contains('https://firebasestorage.googleapis.com/')){
      return 'Photo';
    }else {
      return lastMessage;
    }
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: ref
          .watch(messageServiceProvider)
          .selectCollection(
          ref.watch(messageProvider).data['email'],
          true)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic>? documentData =
          snapshot.data!.data();

          final lastMessage =
          documentData?['lastMessage'];
          if (lastMessage == null) {
            return const Text("");
          } else {
            final lastMessageText =
            documentData?['lastMessage']['msg'];
            final isMe =
            documentData?['lastMessage']['isMe'];
            return Text(isMe == true
                ? 'You: ${controlledLastMessage(lastMessageText)}'
                : controlledLastMessage(lastMessageText));
          }
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else {
          return const Text('Loading..');
        }
      },
    );
  }
}
