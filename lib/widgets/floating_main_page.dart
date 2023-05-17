import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../repository/notes_repository.dart';
import '../screens/add_category.dart';
import '../screens/create_note_page.dart';


class FloatingMainPage extends ConsumerWidget {
  const FloatingMainPage({
    super.key,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () async {
                    Navigator.pop(context);
                    final note = await PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const CreateNote(),
                      withNavBar: false,
                    );
                    ref.read(notesProvider).addNote(note, ref.read(notesProvider).notes);
                  },
                  child: const Text('Add Note'),
                ),
                SimpleDialogOption(
                  onPressed: () async {
                    Navigator.pop(context);
                    await PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const AddCategory(),
                      withNavBar: false,
                    );

                  },
                  child: const Text('Add Category'),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(Icons.add_box_rounded),
    );
  }
}

