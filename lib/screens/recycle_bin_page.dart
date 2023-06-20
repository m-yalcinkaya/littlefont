import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/repository/notes_repository.dart';
import 'package:littlefont_app/screens/view_note_page.dart';
import 'package:littlefont_app/utilities/database_helper.dart';

import '../modals/note.dart';

class RecycleBin extends ConsumerWidget {
  const RecycleBin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteRepo = ref.watch(notesProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Recycle Bin'),
      ),
      body: FutureBuilder<List<Notes>>(
        future: DatabaseHelper.instance.getRecycle(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('An error occurred. Please try again later.'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          } else if (snapshot.hasData) {
            ref.read(notesProvider).recycle = snapshot.data!;
            return noteRepo.recycle.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'No deleted notes',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 75,
                      right: 65,
                      left: 85,
                    ),
                    child: Text(
                      noteRepo.recycleInfo,
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
            )
                : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20) +
                      const EdgeInsets.only(left: 15),
                  child: Text(
                    noteRepo.recycleInfo,
                  ),
                ),
                Expanded(child: buildGridView(ref)),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  GridView buildGridView(WidgetRef ref) {
    final noteRepo = ref.watch(notesProvider);
    final noteReadRepo = ref.read(notesProvider);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: noteRepo.recycle.length,
      itemBuilder: (context, index) {
        return Card(
          color: const Color.fromARGB(200, 200, 250, 220),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowNote(index: index),
              ));
            },
            onLongPress: () {
              showDialog(context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Alert'),
                      content: const Text('Are you sure you want to get the deleted note back?'),
                      actions: [
                        TextButton(onPressed: () {
                          noteReadRepo.addNote(noteReadRepo.recycle[index]);
                          noteReadRepo.removeRecycle(noteReadRepo.recycle[index]);
                          Navigator.of(context).pop();

                        },
                            child: const Text('Revoke')
                        ),
                        TextButton(onPressed: () {
                          Navigator.of(context).pop();
                        },
                            child: const Text('Cancel')
                        ),
                      ],
                    );
                  },
              );
            },
            onDoubleTap: () {
              showDialog(context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Alert'),
                    content: const Text('Are you sure you want to permanently delete the note?'),
                    actions: [
                      TextButton(onPressed: () {
                        noteReadRepo.removeRecycle(noteReadRepo.recycle[index]);
                        Navigator.of(context).pop();
                      },
                          child: const Text('Delete')
                      ),
                      TextButton(onPressed: () {
                        Navigator.of(context).pop();
                      },
                          child: const Text('Cancel')
                      ),
                    ],
                  );
                },
              );
            },
            child: Column(
              children: [
                const Spacer(),
                Expanded(
                  child: Text(
                    noteRepo.recycle[index].title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                        noteRepo.recycle[index].content,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
