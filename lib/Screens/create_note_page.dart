import 'package:flutter/material.dart';
import 'package:littlefont/Repository/notes_repository.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({Key? key}) : super(key: key);

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final headController = TextEditingController();
  final textController = TextEditingController();
  bool isError = false;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    headController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  null;
                },
                icon: const Icon(Icons.font_download),
              ),
              IconButton(
                onPressed: () {
                  null;
                },
                icon: const Icon(Icons.color_lens),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    final isSuitable = formKey.currentState?.validate();

                    isSuitable!
                        ? showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Uyarı Mesajı'),
                              content: const Text(
                                  'Notunuzu kaydetmek istediğinize emin misiniz?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.of(context).maybePop(
                                      Notes(
                                          title: headController.text,
                                          content: textController.text),
                                    );
                                  },
                                  child: const Text('Onayla'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('İptal'),
                                ),
                              ],
                            ),
                          )
                        : null;
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      maxLength: 50,
                      validator: (value) {
                        return value!.length > 50
                            ? 'Başlık 50 den fazla karakter içeremez'
                            : null;
                      },
                      textInputAction: TextInputAction.newline,
                      maxLines: null,
                      controller: headController,
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                      decoration:
                          const InputDecoration(hintText: 'Başlığı girin'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: textController,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Yazmaya başlayın',
                      ),
                      maxLines: null,
                      // or any value greater than 1
                      textInputAction: TextInputAction.newline,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
