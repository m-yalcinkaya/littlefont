import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/repository/news_repository.dart';
import 'package:littlefont/services/news_service.dart';

import '../items/my_grid_view.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage> {
  bool isLoading = false;
  late Future<void> _future;

  List<String> newsCategories = [
    'general',
    'health',
    'entertainment',
    'sports',
    'business',
    'science',
    'technology'
  ];

  void findCategoryList() {
    final refRead = ref.read(newsProvider);
    switch (refRead.selectedValue) {
      case 'general':
        ref.read(newsServiceProvider).selectCategory('general');
        _future = refRead.getNewsByCategory(refRead.generalNews);
        refRead.list = refRead.generalNews;
        break;
      case 'health':
        ref.read(newsServiceProvider).selectCategory('health');
        _future = refRead.getNewsByCategory(refRead.healthNews);
        refRead.list = refRead.healthNews;
        break;
      case 'entertainment':
        ref.read(newsServiceProvider).selectCategory('entertainment');
        _future = refRead.getNewsByCategory(refRead.entertainmentNews);
        refRead.list = refRead.entertainmentNews;
        break;
      case 'sports':
        ref.read(newsServiceProvider).selectCategory('sports');
        _future = refRead.getNewsByCategory(refRead.sportsNews);
        refRead.list = refRead.sportsNews;
        break;
      case 'business':
        ref.read(newsServiceProvider).selectCategory('business');
        _future = refRead.getNewsByCategory(refRead.businessNews);
        refRead.list = refRead.businessNews;
        break;
      case 'science':
        ref.read(newsServiceProvider).selectCategory('science');
        _future = refRead.getNewsByCategory(refRead.scienceNews);
        refRead.list = refRead.scienceNews;
        break;
      case 'technology':
        ref.read(newsServiceProvider).selectCategory('technology');
        _future = refRead.getNewsByCategory(refRead.technologyNews);
        refRead.list = refRead.technologyNews;
        break;
    }
  }

  @override
  void initState() {
    ref.read(newsProvider).selectedValue = 'general';
    findCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newsRepo = ref.watch(newsProvider);
    final newsRepoRead = ref.read(newsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('LittleFont News'),

        actions: [
          buildDropdownButton(newsRepo, newsRepoRead),
        ],
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20) +
                    const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                    'Total Results: ${newsRepo.list.length}')),
          ),
          Expanded(
              child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(
                    'Couldn\'t was downloaded news : NewsPage ${snapshot.error}');
              } else {
                return const MyGridView();
              }
            },
          )),
        ],
      ),
    );
  }

  DropdownButton<String> buildDropdownButton(NewsRepository newsRepo, NewsRepository newsRepoRead) {
    return DropdownButton(
          value: newsRepo.selectedValue,
          items: [
            DropdownMenuItem(
              value: newsCategories[0],
              child: const Text('General'),
            ),
            DropdownMenuItem(
              value: newsCategories[1],
              child: const Text('Health'),
            ),
            DropdownMenuItem(
              value: newsCategories[2],
              child: const Text('Entertainment'),
            ),
            DropdownMenuItem(
              value: newsCategories[3],
              child: const Text('Sports'),
            ),
            DropdownMenuItem(
              value: newsCategories[4],
              child: const Text('Business'),
            ),
            DropdownMenuItem(
              value: newsCategories[5],
              child: const Text("Science"),
            ),
            DropdownMenuItem(
              value: newsCategories[6],
              child: const Text('Technology'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              newsRepoRead.selectedValue = value!;
              findCategoryList();
            });
          },
        );
  }
}
