import 'create_note_page_index.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({Key? key}) : super(key: key);

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final _headController = TextEditingController();
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _headController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
                    final isSuitable = _formKey.currentState?.validate();

                    isSuitable!
                        ? showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Alert'),
                              content: const Text(
                                  'Are you sure you want to save your note?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.of(context).pop(
                                      Notes(
                                          title: _headController.text,
                                          content: _textController.text),
                                    );
                                  },
                                  child: const Text('Save'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context, null);
                                  },
                                  child: const Text('Exit without saving'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
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
                            ? 'Title cannot contain more than 50 characters!'
                            : null;
                      },
                      textInputAction: TextInputAction.newline,
                      maxLines: null,
                      controller: _headController,
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                      decoration:
                          const InputDecoration(hintText: 'Enter title'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _textController,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Start typing',
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
