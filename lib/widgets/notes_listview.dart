import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/repository/notes_repository.dart';


class NotesListview extends ConsumerWidget {
  const NotesListview({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: ref.watch(notesProvider).notes.length,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: 200,
          child: Card(
            child: ListTile(
              title: Text(
                ref.watch(notesProvider).notes[index].title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Center(
                child: Text(
                  ref.watch(notesProvider).notes[index].content,
                  maxLines: 4,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
