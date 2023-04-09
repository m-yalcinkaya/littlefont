import 'package:flutter/material.dart';
import 'package:littlefont/Items/app_drawer.dart';
import 'package:littlefont/Screens/create_note.dart';
import '../Repository/notes_repository.dart';

class MyNotes extends StatefulWidget {
  const MyNotes({Key? key}) : super(key: key);

  @override
  State<MyNotes> createState() => _MyNotesState();
}

NotesRepository notesRepository = NotesRepository();

class _MyNotesState extends State<MyNotes> {
  String? mainText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Merhaba'),
      ),
      body: buildGridView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final note = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CreateNote(),
          ));
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
      itemCount: notesRepository.notlar.length,
      itemBuilder: (context, index) {
        return Card(
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(notesRepository.notlar[index].title),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Kapat'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Center(
              child: Text(notesRepository.notlar[index].content),
            ),
          ),
        );
      },
    );
  }
}
