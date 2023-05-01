import 'package:flutter/material.dart';
import 'package:littlefont/Screens/MessageScreen/message_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
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
        title: Text('LittleFont Chats'),
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
          ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('Mustafa Yalçınkaya'),
                    leading: const CircleAvatar(
                      backgroundImage:
                      AssetImage('assets/images/profil_image.jpg'),
                      radius: 20,
                      backgroundColor: Colors.blue,
                    ),
                    subtitle: Text('Yarın okula gelecek misin?'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MessageScreen(),));
                    },
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                ],
              );
            },
          ),
          Column(
            children: [
              const SizedBox(height: 15,),
              ListTile(
                title: const Text('My Status'),
                subtitle: Text('Tap to add status update'),
                leading: Stack(
                  children: const [
                    CircleAvatar(
                      backgroundImage:
                      AssetImage('assets/images/profil_image.jpg'),
                      radius: 20,
                      backgroundColor: Colors.blue,
                    ),
                    Positioned(
                      top: 22,
                      left: 22,
                        child: Icon(Icons.add_circle, color: Colors.red, size: 20),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 2,),
            ],
          ),
        ],
      ),

    );
  }
}
