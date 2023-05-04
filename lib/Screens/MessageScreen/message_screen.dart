import 'message_screen_index.dart';

class MessageScreen extends ConsumerWidget {
  MessageScreen({Key? key}) : super(key: key);

  final controller = TextEditingController();

  Color _color(bool isMe) {
    if (isMe == true) {
      return Colors.blue;
    }
    return Colors.blueGrey;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                                width: 2, // etkin olmadığında kenarlık rengi
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
                          time: DateTime.now(),
                        );
                        messageReadRepo.addMessage(
                            message, messageReadRepo.messages);
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
