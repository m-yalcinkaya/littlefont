import 'package:flutter/material.dart';
import 'package:littlefont/Repository/notes_repository.dart';
import 'package:littlefont/Screens/ViewNotePage/view_note_page.dart';

class FavouritesPage extends StatefulWidget {
  final NotesRepository notesRepository;

  const FavouritesPage({Key? key, required this.notesRepository})
      : super(key: key);

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
        body: widget.notesRepository.favourites.isEmpty
            ? const Center(
                child: Text(
                'Hiç Favori Notunuz Yok',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ))
            : Padding(
                padding: const EdgeInsets.all(8),
                child: buildGridView(),
              ));
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
          color: widget.notesRepository.favourites[index].color,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowNote(
                    index: index, notesRepository: widget.notesRepository),
              ));
            },
            child: Column(children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      widget.notesRepository.favourites;
                      widget.notesRepository.notes;
                      setState(() {
                        widget.notesRepository.favourites
                            .remove(widget.notesRepository.favourites[index]);
                      });
                      widget.notesRepository.favourites;
                      widget.notesRepository.notes;
                    },
                    icon: const Icon(Icons.star),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  widget.notesRepository.favourites[index].title,
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
                      widget.notesRepository.favourites[index].content,
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
