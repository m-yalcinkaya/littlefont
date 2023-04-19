import 'app_main_index.dart';

class AppMainPage extends StatefulWidget {
  final String? name;
  final String? surname;

  const AppMainPage({
    Key? key,
    required this.name,
    this.surname,
  }) : super(key: key);

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
            pinned: true,
            expandedHeight: 245.0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              expandedTitleScale: 1.5,
              title: Text(
                'Hi, ${widget.name}!',
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
                            MyNotes(notesRepository: notesRepository),
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
                        subtitle: Center(
                          child: Text(
                            notesRepository.notes[index].content,
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
                            CategoryPage(notesRepository: notesRepository),
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
                                  notesRepository: notesRepository,
                                  indexCategory: index),
                            ));
                      },
                      child: Center(
                          child: Text(
                        notesRepository.category[index].categoryName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ),
                  );
                },
                childCount: notesRepository.category.length,
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(
          notesRepository: notesRepository,
          name: widget.name,
          surname: widget.surname),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          null;
        },
        child: PopupMenuButton(
          icon: const Icon(Icons.add),
          onSelected: (value) async {
            if (value == 'note') {
              final note = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CreateNote(),
              ));
              notesRepository.notes.add(note);
              setState(() {});
            } else if (value == 'category') {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    AddCategory(notesRepository: notesRepository),
              ));
              setState(() {});
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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
            label: 'News',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
            label: 'Chats',
          ),
        ],
      ),
    );
  }
}
