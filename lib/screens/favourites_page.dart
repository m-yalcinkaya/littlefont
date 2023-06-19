import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/repository/notes_repository.dart';
import 'package:littlefont_app/screens/view_note_page.dart';
import 'package:littlefont_app/utilities/database_helper.dart';

class FavouritesPage extends ConsumerWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favourites'),
        ),
        body: FutureBuilder(
          future: DatabaseHelper.instance.getFavourites(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('An error occured while loading favourite notes'),
                actions: [
                  ElevatedButton(onPressed: () {
                    Navigator.of(context);
                  }, child: const Text('Ok'))
                ],
              );
            } else if(snapshot.hasData){
              ref.read(notesProvider).favourites = snapshot.data!;
              return ref.watch(notesProvider).favourites.isEmpty
                  ? const Center(
                  child: Text(
                    'No favourite note',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ))
                  : Padding(
                padding: const EdgeInsets.all(8),
                child: buildGridView(ref: ref),
              );
            }else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
    );
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
      itemCount: noteWatchRepo.favourites.length,
      itemBuilder: (context, index) {
        return Card(
          color: const Color.fromARGB(200, 200, 250, 220),
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
                      noteReadRepo.removeFavourite(noteReadRepo.favourites[index]);
                    },
                    icon: const Icon(Icons.star),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  noteReadRepo.favourites[index].title,
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
                      noteReadRepo.favourites[index].content,
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
