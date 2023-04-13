import 'package:flutter/material.dart';
import '../Repository/notes_repository.dart';

class EditPage extends StatefulWidget {
  final Notes note;

  const EditPage({Key? key, required this.note}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool isError = false;
  TextEditingController headController = TextEditingController();
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    textController.text = widget.note.content;
    headController.text = widget.note.title;
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    headController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                if ((widget.note.title == headController.text) &&
                    widget.note.content == textController.text) {
                  Navigator.of(context).maybePop(
                    Notes(
                        title: headController.text,
                        content: textController.text),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => exitAlertDialog(context),
                  );
                }
              },
              icon: const Icon(Icons.arrow_back),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    if ((widget.note.title == headController.text) &&
                        widget.note.content == textController.text) {
                      Navigator.of(context).maybePop(
                        Notes(
                            title: headController.text,
                            content: textController.text),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => saveAlertDialog(context),
                      );
                    }
                  },
                  icon: const Icon(Icons.edit_note),
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
                    TextField(
                      maxLength: 50,
                      onChanged: (value) {
                        setState(() {
                          if (headController.text.length == 50) {
                            isError = true;
                          } else {
                            isError = false;
                          }
                        });
                      },
                      textInputAction: TextInputAction.newline,
                      maxLines: null,
                      controller: headController,
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                      decoration: InputDecoration(
                          errorText: isError
                              ? '50 den fazla karakter giremezsin'
                              : null,
                          hintText: 'Başlığı girin'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
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

  AlertDialog saveAlertDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Uyarı Mesajı'),
      content:
          const Text('Değişiklikleri kaydetmek istediğinize emin misiniz?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cancel');
            Navigator.of(context).maybePop(
              Notes(title: headController.text, content: textController.text),
            );
          },
          child: const Text('Onayla'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              Navigator.pop(context, 'İptal');
            });
          },
          child: const Text('İptal'),
        ),
      ],
    );
  }

  AlertDialog exitAlertDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Uyarı Mesajı'),
      content:
          const Text('Notunuzda değişiklikler var, kaydetmek ister misiniz?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cancel');
            Navigator.of(context).maybePop(
              Notes(title: headController.text, content: textController.text),
            );
          },
          child: const Text('Kaydet'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              Navigator.pop(context, 'Çıkış');
              Navigator.maybePop(context, widget.note);
            });
          },
          child: const Text('Kaydetme'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              Navigator.pop(context, 'Çıkış');
            });
          },
          child: const Text('İptal'),
        ),
      ],
    );
  }
}
