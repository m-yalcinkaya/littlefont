import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:littlefont_app/repository/messages_repository.dart';
import 'package:littlefont_app/screens/search_account.dart';
import 'package:littlefont_app/widgets/chat_list_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


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
            icon: Icon(Icons.search)
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ChatListView(),
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
                    ref.watch(messageProvider).profilImage(FirebaseAuth.instance.currentUser?.photoURL, isBigPhoto: true),
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

