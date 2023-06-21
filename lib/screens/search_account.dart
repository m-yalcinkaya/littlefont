import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../repository/messages_repository.dart';
import 'message_screen.dart';

class SearchAccount extends ConsumerStatefulWidget {
  const SearchAccount({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchAccount> createState() => _SearchAccountState();
}

class _SearchAccountState extends ConsumerState<SearchAccount> {
  late TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Widget profilImage(String? photoUrl) {
    if (photoUrl != null && photoUrl.isNotEmpty) {
      return CircleAvatar(
        backgroundImage: NetworkImage(
            '${ref
                .watch(messageProvider)
                .data['photoUrl']}'),
        radius: 20,
        backgroundColor: Colors.blue,
      );
    }else {
      return const CircleAvatar(
        maxRadius: 16,
        child: Icon(Icons.person),
      );
    }
  }

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: SpinKitCircle(color: Colors.red),);
          }

          List<DocumentSnapshot> documents = snapshot.data!.docs;
          List<DocumentSnapshot> listData = [];

          for(DocumentSnapshot document in documents){
            if(document['email'] != FirebaseAuth.instance.currentUser!.email){
              listData.add(document);
            }
          }

          return ListView.builder(
            itemCount: listData.length,
            itemBuilder: (BuildContext context, int index) {
              ref.watch(messageProvider).data = listData[index].data() as Map<String, dynamic>;


              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      ListTile(
                        title: Text('${ref.watch(messageProvider).data['firstName']} ${ref.watch(messageProvider).data['lastName']}'),
                        leading: profilImage(ref.watch(messageProvider).data["photoUrl"]),
                        subtitle: Text(ref.watch(messageProvider).data['email']),
                        onTap: () {
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
        },
      ),
    );
  }
}
