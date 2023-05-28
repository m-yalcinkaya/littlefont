import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:littlefont/screens/search_account.dart';
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

  final _usersStream = FirebaseFirestore.instance
      .collection('users')
      .snapshots();


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
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              List<DocumentSnapshot> documents = snapshot.data!.docs;

              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          ListTile(
                            title: Text('${data['firstName']} ${data['lastName']}'),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage('${data['photoUrl']}'),
                              radius: 20,
                              backgroundColor: Colors.blue,
                            ),
                            subtitle: Text(data['email']),
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: MessageScreen(email: data['email']),
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
          const Column(
            children: [
              SizedBox(
                height: 15,
              ),
              ListTile(
                title: Text('My Status'),
                subtitle: Text('Tap to add status update'),
                leading: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/profil_image.jpg'),
                      radius: 20,
                      backgroundColor: Colors.blue,
                    ),
                    Positioned(
                      top: 22,
                      left: 22,
                      child:
                          Icon(Icons.add_circle, color: Colors.red, size: 20),
                    ),
                  ],
                ),
              ),
              Divider(
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
