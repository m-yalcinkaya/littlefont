import 'app_main_index.dart';

class AppMainPage extends ConsumerWidget {
  const AppMainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteRepo = ref.watch(notesProvider);
    final categoryRepo = ref.watch(categoryProvider);
    final noteReadRepo = ref.read(notesProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 245.0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              expandedTitleScale: 1.5,
              title: Text(
                'Hi, ${ref.watch(accountProvider).manager.name}!',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              background: const Image(
                image: AssetImage('assets/images/pexels-photo-3225517.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                const SizedBox(
                  width: 25,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MyNotes(),
                      ));
                    },
                    child: const Text('Notes >'),
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
                itemCount: noteRepo.notes.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 200,
                    child: Card(
                      child: ListTile(
                        title: Text(
                          noteRepo.notes[index].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Center(
                          child: Text(
                            noteRepo.notes[index].content,
                            maxLines: 4,
                          ),
                        ),
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
                const SizedBox(
                  width: 25,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CategoryPage(),
                      ));
                    },
                    child: const Text('Categories >'),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ShowCategory(indexCategory: index),
                            ));
                      },
                      child: Center(
                          child: Text(
                        categoryRepo.category[index].categoryName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ),
                  );
                },
                childCount: categoryRepo.category.length,
              ),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          null;
        },
        child: PopupMenuButton(
          icon: const Icon(Icons.add),
          onSelected: (value) async {
            if (value == 'note') {
              final note = await PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const CreateNote(),
                withNavBar: false,
              );
              noteReadRepo.addNote(note, noteReadRepo.notes);
            } else if (value == 'category') {
              await PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const AddCategory(),
                withNavBar: false,
              );
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'note',
                child: Row(
                  children: const [
                    Icon(
                      Icons.note_add,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Add Note'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'category',
                child: Row(
                  children: const [
                    Icon(
                      Icons.add_circle,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Add Category'),
                  ],
                ),
              ),
            ];
          },
        ),
      ),
    );
  }
}
