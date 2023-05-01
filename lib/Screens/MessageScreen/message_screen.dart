import 'dart:math';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({Key? key}) : super(key: key);

  late bool benMi;

  bool _isMe() {
    benMi = Random().nextInt(1000).isEven;
    return benMi;
  }

  Color _color(bool isMe) {
    if (isMe == true) {
      return Colors.blue;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(color: Colors.white);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.arrow_back),
              CircleAvatar(
                radius: 16.0,
                backgroundImage: AssetImage('assets/images/profil_image.jpg'),
              ),
            ],
          ),
        ),
        title: Row(children: const [
          Text('Mustafa Yalçınkaya'),
        ]),
        actions: [
          IconButton(
              onPressed: () {
                print('call with face to face');
              },
              icon: const Icon(Icons.videocam),
          ),
          IconButton(
            onPressed: () {
              print('call with face to face');
            },
            icon: const Icon(Icons.call),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                    AssetImage('assets/images/whatsapp-duvar-kagitlari-8.jpg'),
                    fit: BoxFit.cover,
                  )),
            ),
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Align(
                            alignment: _isMe()
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  constraints: const BoxConstraints(
                                    maxWidth: 100,
                                    maxHeight: 50,
                                  ),
                                  color: _color(benMi),
                                  child: const Text('ClipRRect', style: style),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Spacer(),
                    SizedBox(
                      height: 60,
                      width: 350,
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                    ),
                    const Spacer(),
                    const IconButton(
                      padding: EdgeInsets.only(bottom: 10),
                      onPressed: null,
                      icon: Icon(Icons.send, color: Colors.blue),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
