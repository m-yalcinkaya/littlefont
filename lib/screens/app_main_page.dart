import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/repository/news_repository.dart';
import '../widgets/category_sliver_grid.dart';
import '../widgets/floating_main_page.dart';
import '../widgets/news_listview.dart';
import '../widgets/notes_listview.dart';
import '../modals/news.dart';
import 'package:littlefont/widgets/app_drawer.dart';
import 'package:littlefont/screens/category_page.dart';
import 'package:littlefont/screens/my_notes_page.dart';

class AppMainPage extends ConsumerStatefulWidget {
  const AppMainPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AppMainPage> createState() => _AppMainPageState();
}

class _AppMainPageState extends ConsumerState<AppMainPage> {
  late Future<List<News>?> _future;

  String? name() {
    String? fullName = FirebaseAuth.instance.currentUser!.displayName;
    String name = '';
    for (int i = 0; i < fullName!.length; i++) {
      if (fullName[i] != ' ') {
        name = name + fullName[i];
      } else {
        break;
      }
    }
    return name;
  }

  @override
  void initState() {
    _future = ref
        .read(newsProvider)
        .getNewsByCategory('general', ref.read(newsProvider).generalNews!);
    super.initState();
  }

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
                'Hi, ${name()}!',
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
            child: Column(
              children: [
                Row(
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
                FutureBuilder(
                  future: _future,
                  builder: (context, AsyncSnapshot<List<News>?> snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                          'An error occurred while loading the news ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return SizedBox(
                        height: 150,
                        child: NewsListview(data: snapshot.data!),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                Row(
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
                const SizedBox(
                  height: 150,
                  child: NotesListview(),
                ),
                Row(
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
              ],
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            sliver: CategorySliverGrid(),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      floatingActionButton: const FloatingMainPage(),
    );
  }
}
