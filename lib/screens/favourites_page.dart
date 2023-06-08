import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/repository/notes_repository.dart';
import 'package:littlefont_app/screens/view_note_page.dart';

class FavouritesPage extends ConsumerWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favourites'),
        ),
        body: ref.watch(notesProvider).favourites.isEmpty
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
              ));
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
          color: noteWatchRepo.favourites[index].color,
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
                      noteReadRepo.removeNote(index, noteReadRepo.favourites);
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
