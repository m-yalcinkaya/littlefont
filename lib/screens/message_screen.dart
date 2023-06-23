import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:littlefont_app/services/message_service.dart';
import 'package:path/path.dart';
import '../repository/messages_repository.dart';
import 'package:littlefont_app/modals/message.dart';

import '../widgets/photo_message.dart';


class MessageScreen extends ConsumerStatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends ConsumerState<MessageScreen> {
  final _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _color(bool isMe) {
    if (isMe == true) {
      return Colors.blue;
    }
    return Colors.blueGrey;
  }


  Future<void> _onImageButtonPressed(ImageSource source, {
    required BuildContext context,
  }) async {
    if (context.mounted) {
      try {
        final XFile? pickedFile = await _picker.pickImage(
          maxWidth: 1024,
          maxHeight: 1024,
          imageQuality: 85,
          source: source,
        );
        setState(() {
          _setImageFileListFromFile(pickedFile);
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An Error Occured : $e')));
      }
    }
  }


  Future<void> _setImageFileListFromFile(XFile? file) async {
    if (file == null) return;
    try {
      File imageFile = File(file.path);
      String fileName = basename(imageFile.path);
      Reference storageRef = storage.ref().child(fileName);

      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      setState(() {
        ref.read(messageProvider).sendMessage(ref
            .read(messageProvider)
            .data["email"], downloadURL);
      });
    } catch (e) {
      setState(() {
        throw Exception('An error occured while loading the message to storage');
      });
    }
  }

  Widget? message(BuildContext context, int index) {
    final messageReadRepo = ref.read(messageProvider);
    final messageSource = messageReadRepo.messages[messageReadRepo.messages.length - index - 1].text;
    if (messageSource.contains('https://firebasestorage.googleapis.com/')) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PhotoMessage(photo: messageSource),));
        },
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 320,
          ),
          color: _color(messageReadRepo.messages[messageReadRepo.messages.length - index - 1].isMe),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Image.network(messageSource, fit: BoxFit.cover,)
          ),
        ),
      );
    } else {
      return Container(
        constraints: const BoxConstraints(
          maxWidth: 320,
        ),
        color: _color(messageReadRepo.messages[messageReadRepo.messages.length - index - 1].isMe),
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: AutoSizeText(
              messageSource,
              style: const TextStyle(
                color: Colors.white,
              ),),
        ),
      );
    }
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
              ref.watch(messageProvider).profilImage(messageWatchRepo.data['photoUrl']),
            ],
          ),
        ),
        title: Row(children: [
          Text('${ref
              .watch(messageProvider)
              .data['firstName']} ${ref
              .watch(messageProvider)
              .data['lastName']}'),
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
                    AssetImage(
                        'assets/images/whatsapp-duvar-kagitlari-8.jpg'),
                    fit: BoxFit.cover,
                  )),
            ),
            Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: ref.watch(messageServiceProvider)
                        .selectCollection(ref
                        .watch(messageProvider)
                        .data['email'], true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: Text(
                            'Something went wrong'));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: SpinKitCircle(color: Colors.red),);
                      }

                      Map<String, dynamic>? documentData = snapshot.data!
                          .data();

                      List<dynamic>? listData = documentData?['messages'];
                      ref
                          .watch(messageProvider)
                          .messages = [];
                      List<dynamic> list = listData ?? [];
                      for (Map<String, dynamic> messages in list) {
                        Message message = Message(
                            text: messages['msg'], isMe: messages['isMe']);
                        messageWatchRepo.messages.add(message);
                      }

                      return ListView.builder(
                        reverse: true,
                        itemCount: ref
                            .watch(messageProvider)
                            .messages
                            .length,
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
                                child: message(context, index),
                              ),
                            ),
                          ),],
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
                      width: 300,
                      child: TextField(
                        controller: _controller,
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                children: <Widget>[
                                  SimpleDialogOption(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      _onImageButtonPressed(
                                        context: context,
                                        ImageSource.gallery,
                                      );
                                    },
                                    child: const Row(children: [
                                      Icon(Icons
                                          .photo_size_select_actual_outlined),
                                      SizedBox(width: 5,),
                                      Text('Gallery'),
                                    ]),
                                  ),
                                  SimpleDialogOption(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      _onImageButtonPressed(
                                        ImageSource.camera,
                                        context: context,
                                      );
                                    },
                                    child: const Row(
                                        children: [
                                          Icon(Icons.camera),
                                          SizedBox(width: 5,),
                                          Text('Camera'),
                                        ]),
                                  ),
                                ],
                              );
                            },);
                        },
                        icon: const Icon(
                          Icons.add_circle, size: 30, color: Colors.red,),),
                    ),
                    IconButton(
                      padding: const EdgeInsets.only(bottom: 10),
                      onPressed: () async {
                        try {
                          await ref.read(messageProvider).sendMessage(ref
                              .read(messageProvider)
                              .data['email'], _controller.text);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$e')));
                        }
                        _controller.text = '';
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

