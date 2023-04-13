import 'package:flutter/material.dart';
import 'package:littlefont/Items/app_drawer.dart';
import 'package:littlefont/Repository/notes_repository.dart';
import 'package:littlefont/Screens/add_category.dart';
import 'package:littlefont/Screens/category_page.dart';
import 'package:littlefont/Screens/my_notes_page.dart';
import 'package:littlefont/Screens/show_category_notes.dart';
import 'create_note_page.dart';

class AppMainPage extends StatefulWidget {
  final String? name;
  final String? surname;
  const AppMainPage({Key? key, required this.name, this.surname, }) : super(key: key);

  @override
  State<AppMainPage> createState() => _AppMainPageState();
}

class _AppMainPageState extends State<AppMainPage> {
  final NotesRepository notesRepository = NotesRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: false,
            pinned: true,
            expandedHeight: 245.0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              expandedTitleScale: 1.5,
              title: Text(
                'Merhaba, ${widget.name}!',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              background: const Image(
                image: AssetImage('assets/images/pexels-photo-1563356.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                const SizedBox(width: 25,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyNotes(notesRepository: notesRepository),));
                    },
                    child: const Text('Notlar >'),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 150,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: notesRepository.notes.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 200,
                    child: Card(
                      child: ListTile(
                        title: Text(
                            notesRepository.notes[index].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Center(child: Text(notesRepository.notes[index].content)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                const SizedBox(width: 25,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoryPage(notesRepository: notesRepository),));
                    },
                    child: const Text('Kategoriler >'),
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 2,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  ShowCategory(notesRepository: notesRepository, indexCategory: index),));
                      },
                      child: Center(child: Text(notesRepository.category[index].categoryName)),
                    ),
                  );
                },
                childCount: notesRepository.category.length,
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(notesRepository: notesRepository,name: widget.name, surname: widget.surname),
      floatingActionButton: FloatingActionButton(
        onPressed: () { null; },
        child: PopupMenuButton(
          icon: const Icon(Icons.add),
          onSelected: (value)  {
            if (value == 'note') {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreateNote(),));
            } else if (value == 'category') {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCategory(notesRepository: notesRepository),));
            }
          },
          itemBuilder: (context) {
            return [
              const PopupMenuItem<String>(
                value: 'note',
                child: Text('Not ekle'),
              ),
              const PopupMenuItem<String>(
                value: 'category',
                child: Text('Kategori ekle'),
              ),
            ];
          },
        ),
      ),
    );
  }
}
