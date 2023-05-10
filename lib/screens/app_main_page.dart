import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/repository/news_repository.dart';
import 'package:littlefont/screens/view_news_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:littlefont/repository/notes_repository.dart';
import 'package:littlefont/repository/accounts_repository.dart';
import '../repository/category_repository.dart';
import 'package:littlefont/items/app_drawer.dart';
import 'package:littlefont/screens/add_category.dart';
import 'package:littlefont/screens/category_page.dart';
import 'package:littlefont/screens/my_notes_page.dart';
import 'package:littlefont/screens/show_category_notes.dart';
import 'package:littlefont/screens/create_note_page.dart';

class AppMainPage extends ConsumerStatefulWidget {
  const AppMainPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AppMainPage> createState() => _AppMainPageState();
}

class _AppMainPageState extends ConsumerState<AppMainPage> {
  bool isLoading = false;

  @override
  void initState() {
    ref.read(newsProvider).showNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final noteRepo = ref.watch(notesProvider);
    final categoryRepo = ref.watch(categoryProvider);
    final noteReadRepo = ref.read(notesProvider);
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
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
                      image:
                          AssetImage('assets/images/pexels-photo-3225517.jpg'),
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
                          child: const Text('News >'),
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
                      itemCount: ref.watch(newsProvider).news.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 265,
                          child: InkWell(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: ViewNewsPage(indexNews: index),
                              );
                            },
                            child: Card(
                              child: Stack(
                                children: [
                                  Image.network(
                                    ref
                                        .watch(newsProvider)
                                        .news[index]
                                        .urlToImage ?? 'https://cdn.pixabay.com/photo/2014/06/16/23/39/black-370118_960_720.png',
                                    fit: BoxFit.cover,
                                  ),
                                  Column(children: [
                                    const Expanded(flex: 4, child: SizedBox()),
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                          color: Colors.black38,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Center(
                                              child: AutoSizeText(
                                                  ref
                                                      .watch(newsProvider)
                                                      .news[index]
                                                      .title,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          ),
                                        )),
                                  ]),
                                ],
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
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
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
