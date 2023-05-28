import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageService {


  DocumentReference<Map<String, dynamic>> selectCollection(
      String email, bool isMe) {
    if (isMe) {
      return FirebaseFirestore.instance
          .collection('messages')
          .doc('${FirebaseAuth.instance.currentUser!.email}-$email');
    } else {
      return FirebaseFirestore.instance
          .collection('messages')
          .doc('$email-${FirebaseAuth.instance.currentUser!.email}');
    }
  }



  Future<void> updateJson(String email, String message, bool isMe) async {
    final snapshot = await selectCollection(email, isMe).get();

    if(snapshot.exists){
      final data = snapshot.data();
      List<dynamic> listData = data?['messages'] ?? [];
      final map = {'msg': message, 'isMe': isMe};
      listData.add(map);
      await selectCollection(email, isMe).set({
        'messages': listData,
      });
    } else{
      List<dynamic> listData = [];
      final map = {'msg': message, 'isMe': isMe};
      listData.add(map);
      await selectCollection(email, isMe).set({
        'messages': listData,
      });
    }
  }

}

final messageServiceProvider = Provider((ref) {
  return MessageService();
});
