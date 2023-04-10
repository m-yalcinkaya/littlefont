import 'package:flutter/material.dart';
import 'package:littlefont/Items/app_drawer.dart';
import 'package:littlefont/Screens/create_note_page.dart';
import 'package:littlefont/Screens/edit_page.dart';
import 'package:littlefont/Screens/view_note_page.dart';
import '../Repository/notes_repository.dart';

class MyNotes extends StatefulWidget {
  const MyNotes({Key? key}) : super(key: key);

  @override
  State<MyNotes> createState() => _MyNotesState();
}

NotesRepository notesRepository = NotesRepository();

class _MyNotesState extends State<MyNotes> {
  NotesRepository note = NotesRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(notesRepository: notesRepository),
      appBar: AppBar(
        title: const Text('Notlarım'),
      ),
      body: buildGridView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final note = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CreateNote(),
          ));
          setState(() {
            if(note != null) {
              notesRepository.notes = [...notesRepository.notes, note];
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
      itemCount: notesRepository.notes.length,
      itemBuilder: (context, index) {
        return Card(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ShowNote(index: index, notesRepository: notesRepository),
              ));
            },
            child: Column(children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (notesRepository.favourites
                            .contains(notesRepository.notes[index])) {
                          notesRepository.favourites
                              .remove(notesRepository.notes[index]);
                        } else {
                          notesRepository.favourites
                              .add(notesRepository.notes[index]);
                        }
                      });
                    },
                    icon: notesRepository.favourites
                            .contains(notesRepository.notes[index])
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_outline_rounded),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  notesRepository.notes[index].title,
                ),
              ),
              Expanded(
                child: Text(
                  notesRepository.notes[index].content,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        if(notesRepository.favourites.contains(notesRepository.notes[index])){
                          showDialog(
                              context: context,
                              builder:(context) => buildAlertDialog(context, index)
                          );
                        }else{
                          setState(() {
                            notesRepository.recycle.add(notesRepository.notes[index]);
                            notesRepository.notes.remove(notesRepository.notes[index]);
                          });
                        }
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    IconButton(
                      onPressed: () async {
                        final note = await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditPage(note: notesRepository.notes[index]),));
                        setState(() {
                          note != null ? notesRepository.notes[index] = note : null;
                        });
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ],
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
      content:
      const Text('Notunuz favori olarak işaretlenmiş notunuzu silmek istediğinize emin misiniz?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              notesRepository.recycle.add(notesRepository.notes[index]);
              notesRepository.favourites.remove(notesRepository.notes[index]);
              notesRepository.notes.remove(notesRepository.notes[index]);
            });
          },
          child: const Text('Sil'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('İptal'),
        ),
      ],
    );
  }

}
