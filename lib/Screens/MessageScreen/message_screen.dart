import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
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
              onPressed: () {},
              icon: const Icon(Icons.videocam),
          ),
          IconButton(
            onPressed: () {},
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
                              padding: const EdgeInsets.all(5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: Container(
                                  constraints: const BoxConstraints(
                                    maxWidth: 320,
                                  ),
                                  color: _color(benMi),
                                  child: const Padding(
                                    padding: EdgeInsets.all(15),
                                    child: AutoSizeText(
                                      '321ssdasdasdsdasdasdasdsasdsd',
                                        style: TextStyle(color: Colors.white,
                                        ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
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
