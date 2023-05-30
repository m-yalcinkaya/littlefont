
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:littlefont/repository/messages_repository.dart';
import 'package:littlefont/screens/search_account.dart';
import 'package:littlefont/services/message_service.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/screens/message_screen.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }


  ImageProvider profilImage() {
    final photoUrl = FirebaseAuth.instance.currentUser?.photoURL;
    if (photoUrl != null) {
      return NetworkImage(photoUrl);
    }
    return const AssetImage('assets/images/kuslar.jpg');
  }



  final _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LittleFont Chats'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Chats'),
            Tab(text: 'Status'),
          ],
        ),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          StreamBuilder(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No data available'));
              }

              List<DocumentSnapshot> documents = snapshot.data!.docs;
              ref.watch(messageProvider).chatListData = [];


              for (DocumentSnapshot document in documents) {
                if (document['email'] !=
                    FirebaseAuth.instance.currentUser!.email) {
                  ref.watch(messageProvider).chatListData.add(document);
                }
              }


              return ListView.builder(
                itemCount: ref.watch(messageProvider).chatListData.length,
                itemBuilder: (BuildContext context, int index) {
                  ref.watch(messageProvider).data =
                  ref.watch(messageProvider).chatListData[index].data() as Map<String, dynamic>;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          ListTile(
                            title: Text(
                                '${ref.watch(messageProvider).data['firstName']} ${ref.watch(messageProvider).data['lastName']}'),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  '${ref.watch(messageProvider).data['photoUrl']}'),
                              radius: 20,
                              backgroundColor: Colors.blue,
                            ),
                            subtitle: StreamBuilder(
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
                                        ? 'You: $lastMessageText'
                                        : '$lastMessageText');
                                  }
                                } else if (snapshot.hasError) {
                                  return const Text('Error');
                                } else {
                                  return const Text('Loading..');
                                }
                              },
                            ),
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
          Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              ListTile(
                title: const Text('My Status'),
                subtitle: const Text('Tap to add status update'),
                leading: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: profilImage(),
                      radius: 20,
                      backgroundColor: Colors.blue,
                    ),
                    const Positioned(
                      top: 22,
                      left: 22,
                      child:
                          Icon(Icons.add_circle, color: Colors.red, size: 20),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'ChatFltButton',
        onPressed: () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const SearchAccount(),
          );
        },
        child: const Icon(Icons.add_box_rounded),
      ),
    );
  }
}
