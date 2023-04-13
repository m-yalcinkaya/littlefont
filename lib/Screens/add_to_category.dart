import 'package:flutter/material.dart';
import 'package:littlefont/Repository/notes_repository.dart';
import 'package:littlefont/Screens/view_note_page.dart';

class AddToCategory extends StatefulWidget {
  final NotesRepository notesRepository;
  final int indexCategory;

  const AddToCategory({
    Key? key,
    required this.notesRepository,
    required this.indexCategory,
  }) : super(key: key);

  @override
  State<AddToCategory> createState() => _AddToCategoryState();
}

class _AddToCategoryState extends State<AddToCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            setState(() {});
          },
        ),
        title: const Text('Notlarım'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: buildGridView(),
      ),
    );
  }

  GridView buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: widget.notesRepository.notes.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowNote(
                  index: index,
                  notesRepository: widget.notesRepository,
                ),
              ));
            },
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        final value = widget.notesRepository.notes[index];
                        if (widget.notesRepository
                            .category[widget.indexCategory].notes
                            .contains(value)) {
                          widget.notesRepository.category[widget.indexCategory]
                              .notes
                              .remove(value);
                        } else {
                          widget.notesRepository.category[widget.indexCategory]
                              .notes
                              .add(value);
                        }
                      });
                    },
                    icon: widget.notesRepository.category[widget.indexCategory]
                            .notes
                            .contains(widget.notesRepository.notes[index])
                        ? const Icon(Icons.add_box_rounded)
                        : const Icon(Icons.add_box_outlined),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  widget.notesRepository.notes[index].title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      widget.notesRepository.notes[index].content,
                    ),
                  ),
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
