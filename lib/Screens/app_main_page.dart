import 'package:flutter/material.dart';
import 'package:littlefont/Items/app_drawer.dart';
import 'package:littlefont/Repository/notes_repository.dart';

import 'create_note_page.dart';

class AppMainPage extends StatelessWidget {
  final String? name;

  AppMainPage({Key? key, required this.name}) : super(key: key);

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
                'Merhaba, $name!',
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
            child: SizedBox(
              height: 150,
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
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
                        subtitle: Text(notesRepository.notes[index].content),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 2,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return const Card();
                },
                childCount: 6,
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(notesRepository: notesRepository,),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreateNote(),));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
