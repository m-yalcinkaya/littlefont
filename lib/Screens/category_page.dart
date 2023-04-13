import 'package:flutter/material.dart';
import 'package:littlefont/Repository/notes_repository.dart';
import 'package:littlefont/Screens/add_category.dart';
import 'package:littlefont/Screens/show_category_notes.dart';


class CategoryPage extends StatelessWidget {
  final NotesRepository notesRepository;
  const CategoryPage({Key? key, required this.notesRepository,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategoriler'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => AddCategory(notesRepository: notesRepository),));
              },
              icon: const Icon(Icons.add_circle, color: Colors.white),
          )

        ],
      ),
      body: buildGridView(),
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
      itemCount: notesRepository.category.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowCategory(
                    indexCategory: index, notesRepository: notesRepository,),
              ));
            },
            child: Column(children: [
              Expanded(
                  child: Center(child: Text(notesRepository.category[index].categoryName)),
              ),
            ]),
          ),
        );
      },
    );
  }
}

