import 'package:flutter/material.dart';
import 'package:littlefont/Repository/notes_repository.dart';
import 'package:littlefont/Screens/view_note_page.dart';

class FavouritesPage extends StatefulWidget {

  final NotesRepository notesRepository;
  const FavouritesPage({Key? key, required this.notesRepository}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('Favoriler'),
        ),
        body: buildGridView());
  }

  GridView buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: widget.notesRepository.favourites.length,
      itemBuilder: (context, index) {
        return Card(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ShowNote(index: index, notesRepository: widget.notesRepository),
              ));
            },
            child: Column(children: [
              const Spacer(),
              Expanded(
                child: Text(
                  widget.notesRepository.favourites[index].title,
                ),
              ),
              Expanded(
                child: Text(
                  widget.notesRepository.favourites[index].content,
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
