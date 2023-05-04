import 'package:flutter/material.dart';
import 'package:littlefont/modals/note.dart';

class EditPage extends StatefulWidget {
  final Notes note;

  const EditPage({Key? key, required this.note}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _headController = TextEditingController();
  final _textController = TextEditingController();

  @override
  void initState() {
    _textController.text = widget.note.content;
    _headController.text = widget.note.title;
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _headController.dispose();
    super.dispose();
  }

  void isChanged(Notes note, AlertDialog alertDialog) {
    if ((widget.note.title == _headController.text) &&
        widget.note.content == _textController.text) {
      Navigator.of(context).pop(note);
    } else {
      showDialog(
        context: context,
        builder: (context) => alertDialog,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              isChanged(
                  Notes(
                      title: _headController.text,
                      content: _textController.text),
                  exitAlertDialog(context));
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  isChanged(widget.note, saveAlertDialog(context));
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
                  TextField(
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
        ));
  }

  AlertDialog saveAlertDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Alert'),
      content:
          const Text('Are you sure you want to save changes?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).pop(
              Notes(title: _headController.text, content: _textController.text),
            );
          },
          child: const Text('Approve'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  AlertDialog exitAlertDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Alert'),
      content:
          const Text('There are changes in your note, do you want to save it?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).pop(
              Notes(title: _headController.text, content: _textController.text),
            );
          },
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context, widget.note);
          },
          child: const Text('Don\'t save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
