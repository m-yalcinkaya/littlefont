import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'app_main_index.dart';

class AppMainPage extends ConsumerWidget {
  final String? name;
  final String? surname;

  const AppMainPage({
    Key? key,
    this.name,
    this.surname,
  }) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                'Hi, $name!',
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
                        builder: (context) =>
                            const MyNotes(),
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
                itemCount: ref.watch(notesProvider).notes.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 200,
                    child: Card(
                      child: ListTile(
                        title: Text(
                          ref.watch(notesProvider).notes[index].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Center(
                          child: Text(
                            ref.watch(notesProvider).notes[index].content,
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
                        builder: (context) =>
                            const CategoryPage(),
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
                              builder: (context) => ShowCategory(
                                  indexCategory: index),
                            ));
                      },
                      child: Center(
                          child: Text(
                        ref.watch(categoryProvider).category[index].categoryName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ),
                  );
                },
                childCount: ref.watch(categoryProvider).category.length,
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(
          name: name,
          surname: surname),
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
              ref.read(notesProvider).addNote(note,ref.read(notesProvider).notes);
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
