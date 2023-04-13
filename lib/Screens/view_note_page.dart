import 'package:flutter/material.dart';
import 'package:littlefont/Repository/notes_repository.dart';

class ShowNote extends StatelessWidget {
  final int index;
  final NotesRepository notesRepository;
  const ShowNote({Key? key, required this.index, required this.notesRepository}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 300,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    notesRepository.notes[index].title,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                child: Text(notesRepository.notes[index].content),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ShowCategoryNote extends StatelessWidget {
  final int index;
  final NotesRepository notesRepository;
  final int indexCategory;
  const ShowCategoryNote({Key? key, required this.index, required this.notesRepository, required this.indexCategory,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 300,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    notesRepository.category[indexCategory].notes[index].title,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                child: Text(
                  notesRepository.category[indexCategory].notes[index].title,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






