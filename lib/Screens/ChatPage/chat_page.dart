import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';


import '../MessageScreen/message_screen.dart';


class ChatScreen extends StatefulWidget {
  final PersistentTabController persistentController;

  const ChatScreen({Key? key, required this.persistentController})
      : super(key: key);

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

  List<String> kisi = [
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
            itemCount: kisi.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Slidable(
                    key: UniqueKey(),
                    // The start action pane is the one at the left or the top side.
                    startActionPane: ActionPane(
                      // A motion is a widget used to control how the pane animates.
                      motion: const ScrollMotion(),

                      // A pane can dismiss the Slidable.
                      dismissible: DismissiblePane(
                          onDismissed: () {
                            setState(() {
                              kisi.removeAt(index);
                            });
                          }),

                      // All actions are defined in the children parameter.
                      children: const [
                        // A SlidableAction can have an icon and/or a label.
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
                          title: Text(kisi[index]),
                          leading: const CircleAvatar(
                            backgroundImage:
                            AssetImage('assets/images/profil_image.jpg'),
                            radius: 20,
                            backgroundColor: Colors.blue,
                          ),
                          subtitle: const Text('Yarın okula gelecek misin?'),
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
            },
          ),
          Column(
            children: [
              const SizedBox(height: 15,),
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
                      child: Icon(
                          Icons.add_circle, color: Colors.red, size: 20),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 2,),
            ],
          ),
        ],
      ),

    );
  }
}
