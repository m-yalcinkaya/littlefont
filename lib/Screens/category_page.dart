import 'package:flutter/material.dart';
import 'package:littlefont/Repository/notes_repository.dart';
import 'package:littlefont/Screens/add_category.dart';
import 'package:littlefont/Screens/show_category_notes.dart';

class CategoryPage extends StatefulWidget {
  final NotesRepository notesRepository;

  const CategoryPage({
    Key? key,
    required this.notesRepository,
  }) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategoriler'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    AddCategory(notesRepository: widget.notesRepository),
              ));
            },
            icon: const Icon(Icons.add_circle, color: Colors.white),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: buildGridView(),
      ),
    );
  }

  GridView buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 3/2,
      ),
      itemCount: widget.notesRepository.category.length,
      itemBuilder: (context, index) {
        return Card(
          color: const Color.fromARGB(150, 120, 220, 220),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowCategory(
                  indexCategory: index,
                  notesRepository: widget.notesRepository,
                ),
              ));
            },
            child: Column(children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Uyarı'),
                        content: const Text(
                            'Bu kategoriyi silmek istediğinize emin misiniz?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              widget.notesRepository.category.remove(
                                  widget.notesRepository.category[index]);
                            },
                            child: const Text('Sil'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('İptal'),
                          ),
                        ],
                      ),
                    );
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                widget.notesRepository.category[index].categoryName,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              )),
            ]),
          ),
        );
      },
    );
  }
}
