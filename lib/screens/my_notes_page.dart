
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:littlefont_app/screens/create_note_page.dart';
import 'package:littlefont_app/screens/edit_page.dart';
import 'package:littlefont_app/screens/view_note_page.dart';
import '../repository/notes_repository.dart';
import '../utilities/database_helper.dart';

class MyNotes extends ConsumerStatefulWidget{
  const MyNotes({Key? key}) : super(key: key);


  @override
  ConsumerState<MyNotes> createState() => _MyNotesState();
}

class _MyNotesState extends ConsumerState<MyNotes> {
  late bool isRight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
      ),
      body: FutureBuilder(
        future: DatabaseHelper.instance.getNotes(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
                  return AlertDialog(
                    title: const Text('Error'),
                    content: const Text('An error occured while loading notes. please try again later'),
                    actions: [
                      ElevatedButton(onPressed: Navigator.of(context).pop,
                          child: const Text('Ok'))
                    ],
                  );
          }else if(snapshot.hasData){
            ref.read(notesProvider).notes = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: buildGridView(ref: ref),
            );
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final note = await PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const CreateNote(),
            withNavBar: false,
          );
          if (note != null) {
            try{
                await ref.read(notesProvider).addNote(note);
            } catch (e) {
              AlertDialog(
                title: const Text('Error'),
                content: const Text(
                    'An error occurred due to an unknown error. couldn\'t add note),'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Ok'),
                  )
                ],
              );
            }
          } else {
            return;
          }
        },
        tooltip: 'Add note',
        child: const Icon(Icons.add),
      ),
    );
  }

  Icon? isFavourite(noteWatchRepo, index){
    if(noteWatchRepo.notes[index].isFavourite == 1){
      return const Icon(Icons.favorite, color: Colors.red,);
    }else{
      return const Icon(Icons.favorite_outline_rounded, color: Colors.black);
    }
  }

  Future<void> favouriteOperation(NotesRepository noteReadRepo, int index) async {
    if(await DatabaseHelper.instance.isContain(noteReadRepo, index)){
      ref.read(notesProvider).removeFavourite(noteReadRepo.notes[index]);
    } else {
      ref.read(notesProvider).addFavourite(noteReadRepo.notes[index]);
    }
  }

  Future<void> delete(NotesRepository noteReadRepo, int index, context, WidgetRef ref) async {
    if (await DatabaseHelper.instance.isContain(noteReadRepo, index)) {
      showDialog(
          context: context,
          builder: (context) => buildAlertDialog(context, index, ref: ref));
    } else {
      final interValue = noteReadRepo.notes[index];
      ref.read(notesProvider).addRecycle(interValue);
      ref.read(notesProvider).removeNote(interValue);
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
        return GestureDetector(
          onDoubleTap: () {
            favouriteOperation(noteReadRepo, index);
          },
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowNote(index: index)));
          },
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) async {
                if(direction == DismissDirection.startToEnd){
                  await delete(noteReadRepo, index, context, ref);
                }
              },
              direction: DismissDirection.startToEnd,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(right: 15.0),
                child: const Icon(Icons.delete),
              ),
              child: Card(
                color: const Color.fromARGB(200, 200, 250, 220),
                child: Column(children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          favouriteOperation(noteReadRepo, index);
                        },
                        icon: isFavourite(noteWatchRepo, index)!,
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
                            await delete(noteReadRepo, index, context, ref);
                          } else if (value == 'edit') {
                            final note =
                                await PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: EditPage(note: noteReadRepo.notes[index]),
                              withNavBar: false,
                            );
                            note != null
                                ? noteWatchRepo.updateNote(note)
                                : null;
                          } else if (value == 'share') {
                            await FlutterShare.share(
                              title: 'Share your note',
                              text:
                                  '${noteReadRepo.notes[index].title}\n\n${noteReadRepo.notes[index].content}',
                            );
                          }
                        },
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'share',
                              child: Text('Share'),
                            )
                          ];
                        },
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ),
        );
      },
    );
  }

  AlertDialog buildAlertDialog(BuildContext context, int index,
      {required WidgetRef ref}) {
    final noteReadRepo = ref.read(notesProvider);
    return AlertDialog(
      title: const Text('Alert'),
      content: const Text(
          'Your note is marked as favourite, are you sure to delete your note?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            noteReadRepo.addRecycle(noteReadRepo.notes[index]);
            noteReadRepo.removeNote(noteReadRepo.notes[index]);
          },
          child: const Text('Delete'),
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

