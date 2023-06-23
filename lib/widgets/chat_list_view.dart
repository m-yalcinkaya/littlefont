import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:littlefont_app/widgets/last_message_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../repository/messages_repository.dart';
import '../screens/message_screen.dart';

class ChatListView extends ConsumerWidget {
  ChatListView({Key? key}) : super(key: key);


  final _usersStream =
  FirebaseFirestore.instance.collection('users').snapshots();




  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: _usersStream,
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: SpinKitCircle(color: Colors.red),);
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        }else {
          List<DocumentSnapshot> documents = snapshot.data!.docs;
          ref.watch(messageProvider).chatListData = [];


          for (int i=0; i<documents.length; i++) {
            final myEmail = FirebaseAuth.instance.currentUser!.email;
            final email = documents[i]['email'];
            final data = documents[i].data() as Map<String, dynamic>;
            if(email != myEmail) {
              ref.read(messageProvider).chatListData.add(data);
            }
          }


          return ListView.builder(
            itemCount: ref.watch(messageProvider).chatListData.length,
            itemBuilder: (BuildContext context, int index) {
              ref.watch(messageProvider).data = ref.watch(messageProvider).chatListData[index];

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      ListTile(
                        title: Text(
                            '${ref.watch(messageProvider).data['firstName']} ${ref.watch(messageProvider).data['lastName']}'),
                        leading: ref.watch(messageProvider).profilImage(ref.watch(messageProvider).data['photoUrl']),
                        subtitle: const LastMessageWidget(),
                        onTap: () {
                          ref.watch(messageProvider).data =
                          ref.watch(messageProvider).chatListData[index];
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const MessageScreen(),
                            withNavBar: false,
                          );
                        },
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
