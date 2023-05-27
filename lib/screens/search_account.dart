import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*title: TextField(
          controller: _textController,
          onChanged: (value) {
            null;
          },
        ),*/
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      ListTile(
                        title: Text('${data['firstName']} ${data['lastName']}'),
                        leading: CircleAvatar(
                          backgroundImage:
                          NetworkImage('${data['photoUrl']}'),
                          radius: 20,
                          backgroundColor: Colors.blue,
                        ),
                        subtitle: Text(data['email']),
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
              /*return ListTile(
                title: Text('${data['firstName']} ${data['lastName']}'),
                subtitle: Text(data['email']),
              );*/
            }).toList(),
          );
        },
      ),
    );
  }
}
