import 'package:flutter/material.dart';
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

  final List<String> _kisi = [
    'Zeynep Körük',
    'Mustafa Yalçınkaya',
    'Meryem Uzerli',
    'Kemal Sunal',
    'Selim Ak',
  ];

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
          ListView.builder(
            itemCount: _kisi.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Slidable(
                    key: UniqueKey(),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {
                        setState(() {
                          _kisi.removeAt(index);
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
                          title: Text(_kisi[index]),
                          leading: const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/profil_image.jpg'),
                            radius: 20,
                            backgroundColor: Colors.blue,
                          ),
                          subtitle: Text(
                              ref.watch(messageProvider).messages.last.text),
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: MessageScreen(),
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
    );
  }
}
