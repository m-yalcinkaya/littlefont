import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:littlefont/screens/search_account.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/screens/message_screen.dart';
import 'package:littlefont/repository/messages_repository.dart';

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
            stream: FirebaseFirestore.instance
                .collection('users')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Slidable(
                        key: UniqueKey(),
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          dismissible: DismissiblePane(onDismissed: () {
                            setState(() {
                              /*_kisi.removeAt(index);*/
                            });
                          }),
                          children: const [
                            SlidableAction(
                              onPressed: null,
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        endActionPane: null,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(data['name']),
                              leading: const CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/images/profil_image.jpg'),
                                radius: 20,
                                backgroundColor: Colors.blue,
                              ),
                              subtitle: Text(ref
                                  .watch(messageProvider)
                                  .messages
                                  .last
                                  .text),
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
                      ),
                    ],
                  );
                }).toList(),
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
