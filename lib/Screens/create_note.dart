import 'package:flutter/material.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({Key? key}) : super(key: key);

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final headController = TextEditingController();
  final textController = TextEditingController();
  bool isError = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    headController.dispose();
    textController.dispose();
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
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title:const  Text('Uyarı Mesajı'),
                      content: const Text('Notunuzu kaydetmek istediğinize emin misiniz?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context, 'Cancel');
                              Navigator.of(context).maybePop(textController.text);
                            });
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
                    ),
                  ),
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
                    TextField(
                      maxLength: 50,
                      onChanged: (value) {
                        setState(() {
                          if(headController.text.length == 50) {
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
                        errorText: isError ? '50 den fazla karakter giremezsin': null,
                        hintText: 'Başlığı girin'
                      ),
                    ),
                    const SizedBox(height: 20,),
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
}
