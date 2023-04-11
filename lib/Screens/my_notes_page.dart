import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:littlefont/Screens/create_note_page.dart';
import 'package:littlefont/Screens/edit_page.dart';
import 'package:littlefont/Screens/view_note_page.dart';
import '../Repository/notes_repository.dart';

class MyNotes extends StatefulWidget {
  final NotesRepository notesRepository;

  const MyNotes({Key? key, required this.notesRepository}) : super(key: key);

  @override
  State<MyNotes> createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notlarım'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: buildGridView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final note = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CreateNote(),
          ));
          setState(() {
            if (note != null) {
              widget.notesRepository.notes = [
                ...widget.notesRepository.notes,
                note
              ];
            }
          });
        },
        tooltip: 'Not Ekle',
        child: const Icon(Icons.add),
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
          color: widget.notesRepository.notes[index].color,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowNote(
                    index: index, notesRepository: widget.notesRepository),
              ));
            },
            child: Column(children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        final value = widget.notesRepository.notes[index];
                        if (widget.notesRepository.favourites.contains(value)) {
                          widget.notesRepository.favourites.remove(value);
                        } else {
                          widget.notesRepository.favourites.add(value);
                        }
                      });
                    },
                    icon: widget.notesRepository.favourites
                            .contains(widget.notesRepository.notes[index])
                        ? const Icon(Icons.star)
                        : const Icon(Icons.star_border),
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
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: PopupMenuButton(
                    onSelected: (value) async {
                      if (value == 'delete') {
                        if (widget.notesRepository.favourites
                            .contains(widget.notesRepository.notes[index])) {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  buildAlertDialog(context, index));
                          setState(() {});
                        } else {
                          setState(() {
                            widget.notesRepository.recycle
                                .add(widget.notesRepository.notes[index]);
                            final interValue =
                                widget.notesRepository.notes[index];
                            widget.notesRepository.notes.remove(interValue);
                          });
                        }
                      } else if (value == 'edit') {
                        final note =
                            await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditPage(
                              note: widget.notesRepository.notes[index]),
                        ));
                        setState(() {
                          note != null
                              ? widget.notesRepository.notes[index] = note
                              : null;
                        });
                      } else if (value == 'share') {
                        await FlutterShare.share(
                          title: 'Notunu Paylaş',
                          text: '',
                        );
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Text('Sil'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Text('Düzenle'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'share',
                          child: Text('Paylaş'),
                        )
                      ];
                    },
                  ),
                ),
              )
            ]),
          ),
        );
      },
    );
  }

  AlertDialog buildAlertDialog(BuildContext context, int index) {
    return AlertDialog(
      title: const Text('Uyarı Mesajı'),
      content: const Text(
          'Notunuz favori olarak işaretlenmiş notunuzu silmek istediğinize emin misiniz?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              widget.notesRepository.recycle
                  .add(widget.notesRepository.notes[index]);
              final interValue = widget.notesRepository.notes[index];
              widget.notesRepository.favourites.remove(interValue);
              widget.notesRepository.notes.remove(interValue);
            });
          },
          child: const Text('Sil'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
          child: const Text('İptal'),
        ),
      ],
    );
  }
}
