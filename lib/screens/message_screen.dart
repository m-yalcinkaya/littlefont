
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/services/message_service.dart';
import '../repository/messages_repository.dart';
import 'package:littlefont_app/modals/message.dart';

class MessageScreen extends ConsumerStatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends ConsumerState<MessageScreen> {
  final controller = TextEditingController();

  bool isDocumentNull = false;

  Color _color(bool isMe) {
    if (isMe == true) {
      return Colors.blue;
    }
    return Colors.blueGrey;
  }


  @override
  Widget build(BuildContext context) {
    final messageWatchRepo = ref.watch(messageProvider);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.arrow_back),
              CircleAvatar(
                radius: 16.0,
                backgroundImage: NetworkImage('${ref.watch(messageProvider).data['photoUrl']}'),
              ),
            ],
          ),
        ),
        title: Row(children: [
          Text('${ref.watch(messageProvider).data['firstName']} ${ref.watch(messageProvider).data['lastName']}'),
        ]),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam),
          ),
          // HttpIconButton(messageReadRepo: messageReadRepo),
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
                  child: StreamBuilder(
                    stream: ref.watch(messageServiceProvider).selectCollection(ref.watch(messageProvider).data['email'], true).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: Text('Something went wrong'));
                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      Map<String, dynamic>? documentData = snapshot.data!.data();

                      List<dynamic>? listData = documentData?['messages'];
                      ref.watch(messageProvider).messages = [];
                      List<dynamic> list = listData ?? [];
                      for(Map<String, dynamic> messages in list){
                        Message message = Message(text: messages['msg'], isMe: messages['isMe']);
                        messageWatchRepo.messages.add(message);
                      }

                      return ListView.builder(
                        reverse: true,
                        itemCount: ref.watch(messageProvider).messages.length,
                        itemBuilder: (BuildContext context, int index) {

                          return Column(
                            children: [
                              Align(
                                alignment: messageWatchRepo.messages
                                [messageWatchRepo.messages.length -
                                    index - 1]
                                    .isMe
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        maxWidth: 320,
                                      ),
                                      color: _color(messageWatchRepo
                                          .messages[
                                      messageWatchRepo.messages.length -
                                          index -
                                          1]
                                          .isMe),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: AutoSizeText(
                                          messageWatchRepo
                                              .messages[
                                          messageWatchRepo.messages.length -
                                              index -
                                              1]
                                              .text,
                                          style: const TextStyle(
                                            color: Colors.white,
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
                        controller: controller,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(15),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      padding: const EdgeInsets.only(bottom: 10),
                      onPressed: () async {
                        try{
                          await ref.read(messageProvider).sendMessage(ref.read(messageProvider).data['email'], controller.text);
                        } catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
                        }
                        controller.text = '';
                      },
                      icon: const Icon(Icons.send, color: Colors.blue),
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

