import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/messages_repository.dart';
import 'package:littlefont/modals/message.dart';

class MessageScreen extends ConsumerStatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends ConsumerState<MessageScreen> {
  final controller = TextEditingController();

  Color _color(bool isMe) {
    if (isMe == true) {
      return Colors.blue;
    }
    return Colors.blueGrey;
  }

  @override
  void initState() {
    Future.delayed(Duration.zero,() => ref.read(messageProvider).downloadAsList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final messageReadRepo = ref.read(messageProvider);
    final messageWatchRepo = ref.watch(messageProvider);
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
          HttpIconButton(messageReadRepo: messageReadRepo),
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
                    itemCount: messageWatchRepo.messages.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Align(
                            alignment: messageWatchRepo
                                    .messages[messageWatchRepo.messages.length -
                                        index -
                                        1]
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
                      onPressed: () {
                        final message = Message(
                          text: controller.text,
                          isMe: true,
                        );
                        messageReadRepo.sendMessage(message);
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

class HttpIconButton extends ConsumerStatefulWidget {
  const HttpIconButton({
    super.key,
    required this.messageReadRepo,
  });

  final MessagesRepository messageReadRepo;

  @override
  ConsumerState<HttpIconButton> createState() => _HttpIconButtonState();
}

class _HttpIconButtonState extends ConsumerState<HttpIconButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator(
            color: Colors.white,
          )
        : IconButton(
            onPressed: () async {
              try {
                setState(() {
                  isLoading = true;
                });
                await widget.messageReadRepo.downloadAsList();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error : ${e.toString()}')));
              } finally {
                setState(() {
                  isLoading = false;
                });
              }
            },
            icon: const Icon(Icons.call),
          );
  }
}
