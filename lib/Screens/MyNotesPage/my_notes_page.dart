import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          final note = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CreateNote(),
          ));
          if (note != null) {
            ref.read(notesProvider).addNote(note, ref.read(notesProvider).notes);
          }else {
            return;
          }
        },
        tooltip: 'Not Ekle',
        child: const Icon(Icons.add),
      ),
    );
  }

  GridView buildGridView({required WidgetRef ref}) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: ref.watch(notesProvider).notes.length,
      itemBuilder: (context, index) {
        return Card(
          color: ref.watch(notesProvider).notes[index].color,
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
                      final value = ref.read(notesProvider).notes[index];
                      if (ref.read(notesProvider).favourites.contains(value)) {
                        ref.read(notesProvider).removeNoteWithValue(value, ref.read(notesProvider).favourites);
                      } else {
                        ref.read(notesProvider).addNote(value, ref.read(notesProvider).favourites);
                      }
                    },
                    icon: ref.watch(notesProvider).favourites.contains(ref.read(notesProvider).notes[index])
                        ? const Icon(Icons.star) : const Icon(Icons.star_border),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  ref.watch(notesProvider).notes[index].title,
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
                      ref.watch(notesProvider).notes[index].content,
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
                        if (ref
                            .read(notesProvider)
                            .favourites
                            .contains(ref.read(notesProvider).notes[index])) {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  buildAlertDialog(context, index, ref: ref));
                        } else {
                          ref
                              .read(notesProvider)
                              .recycle
                              .add(ref.read(notesProvider).notes[index]);
                          final interValue =
                              ref.read(notesProvider).notes[index];
                          ref.read(notesProvider).notes.remove(interValue);
                        }
                      } else if (value == 'edit') {
                        final note =
                            await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditPage(
                              note: ref.read(notesProvider).notes[index]),
                        ));
                        note != null
                            ? ref.read(notesProvider).notes[index] = note
                            : null;
                      } else if (value == 'share') {
                        await FlutterShare.share(
                          title: 'Notunu Paylaş',
                          text:
                              '${ref.read(notesProvider).notes[index].title}\n\n${ref.read(notesProvider).notes[index].content}',
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
    return AlertDialog(
      title: const Text('Uyarı Mesajı'),
      content: const Text(
          'Notunuz favori olarak işaretlenmiş notunuzu silmek istediğinize emin misiniz?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            ref
                .read(notesProvider)
                .recycle
                .add(ref.read(notesProvider).notes[index]);
            final interValue = ref.read(notesProvider).notes[index];
            ref.read(notesProvider).removeNote(index,ref.read(notesProvider).notes);
            ref.read(notesProvider).removeNote(index,ref.read(notesProvider).notes);
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
