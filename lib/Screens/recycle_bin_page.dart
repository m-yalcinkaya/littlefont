import 'package:flutter/material.dart';
import 'package:littlefont/Repository/notes_repository.dart';
import 'package:littlefont/Screens/view_note_page.dart';

class RecycleBin extends StatefulWidget {
  final NotesRepository notesRepository;
  const RecycleBin({Key? key, required this.notesRepository}) : super(key: key);

  @override
  State<RecycleBin> createState() => _RecycleBinState();
}

class _RecycleBinState extends State<RecycleBin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('Çöp Kutusu'),
        ),
        body: buildGridView());
  }


  GridView buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: widget.notesRepository.recycle.length,
      itemBuilder: (context, index) {
        return Card(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ShowNote(index: index, notesRepository: widget.notesRepository),
              ));
            },
            onLongPress: () {
              setState(() {
                widget.notesRepository.notes.add(widget.notesRepository.notes[index]);
                widget.notesRepository.recycle.remove(widget.notesRepository.notes[index]);
              });
            },
            child: Column(children: [
              const Spacer(),
              Expanded(
                child: Text(
                  widget.notesRepository.recycle[index].title,
                ),
              ),
              Expanded(
                child: Text(
                  widget.notesRepository.recycle[index].content,
                ),
              ),
              const Spacer(),
            ]),
          ),
        );
      },
    );
  }
}
