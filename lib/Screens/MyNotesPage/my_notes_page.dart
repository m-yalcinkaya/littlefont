import 'my_notes_page_index.dart';

class MyNotes extends ConsumerWidget {
  const MyNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notlarım'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: buildGridView(ref: ref),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final noteReadRepo = ref.read(notesProvider);
          final note = await PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const CreateNote(),
            withNavBar: false,
          );
          if (note != null) {
            noteReadRepo.addNote(note, noteReadRepo.notes);
          } else {
            return;
          }
        },
        tooltip: 'Not Ekle',
        child: const Icon(Icons.add),
      ),
    );
  }

  void isContain(NotesRepository noteReadRepo, int index) {
    final value = noteReadRepo.notes[index];
    if (noteReadRepo.favourites.contains(value)) {
      noteReadRepo.removeNoteWithValue(value, noteReadRepo.favourites);
    } else {
      noteReadRepo.addNote(value, noteReadRepo.favourites);
    }
  }

  void delete(NotesRepository noteReadRepo, int index, context, WidgetRef ref) {
    if (noteReadRepo.favourites.contains(noteReadRepo.notes[index])) {
      showDialog(
          context: context,
          builder: (context) => buildAlertDialog(context, index, ref: ref));
    } else {
      noteReadRepo.recycle.add(noteReadRepo.notes[index]);
      final interValue = noteReadRepo.notes[index];
      noteReadRepo.removeNoteWithValue(interValue, noteReadRepo.notes);
    }
  }

  GridView buildGridView({required WidgetRef ref}) {
    final noteReadRepo = ref.read(notesProvider);
    final noteWatchRepo = ref.watch(notesProvider);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: noteWatchRepo.notes.length,
      itemBuilder: (context, index) {
        return Card(
          color: noteWatchRepo.notes[index].color,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowNote(index: index),
              ));
            },
            child: Column(children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      isContain(noteReadRepo, index);
                    },
                    icon: noteWatchRepo.favourites
                            .contains(noteWatchRepo.notes[index])
                        ? const Icon(Icons.star)
                        : const Icon(Icons.star_border),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  noteWatchRepo.notes[index].title,
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
                      noteWatchRepo.notes[index].content,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: PopupMenuButton(
                    onSelected: (value) async {
                      if (value == 'delete') {
                        delete(noteReadRepo, index, context, ref);
                      } else if (value == 'edit') {
                        final note =
                            await PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: EditPage(note: noteReadRepo.notes[index]),
                          withNavBar: false,
                        );
                        note != null
                            ? noteWatchRepo.updateNote(index, note)
                            : null;
                      } else if (value == 'share') {
                        await FlutterShare.share(
                          title: 'Notunu Paylaş',
                          text:
                              '${noteReadRepo.notes[index].title}\n\n${noteReadRepo.notes[index].content}',
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

  AlertDialog buildAlertDialog(BuildContext context, int index,
      {required WidgetRef ref}) {
    final noteReadRepo = ref.read(notesProvider);
    return AlertDialog(
      title: const Text('Uyarı Mesajı'),
      content: const Text(
          'Notunuz favori olarak işaretlenmiş notunuzu silmek istediğinize emin misiniz?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            noteReadRepo.recycle.add(noteReadRepo.notes[index]);
            final noteRepo = noteReadRepo;
            noteRepo.removeNote(index, noteRepo.notes);
            noteRepo.removeNote(index, noteRepo.notes);
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
