import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/repository/news_repository.dart';
import 'package:littlefont/services/news_service.dart';

import '../items/my_grid_view.dart';
import '../modals/news.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage> {
  late Future<List<News>?> _future;
  late String categoryTitle;
  late String _selectedValue;

  @override
  void initState() {
    _selectedValue = 'general';
    categoryTitle = 'General';
    ref.read(newsServiceProvider).selectCategory('general');
    _future = ref
        .read(newsProvider)
        .getNewsByCategory(ref.read(newsProvider).generalNews);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newsRepo = ref.read(newsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle != 'General'
            ? 'LittleFont News | $categoryTitle'
            : 'LittleFont News'),
        actions: [
          IconButton(
              onPressed: () async {
                showMenu(
                  context: context,
                  position: const RelativeRect.fromLTRB(25.0, 25.0, 0.0, 0.0),
                  items: [
                    PopupMenuItem(
                      value: 'general',
                      child: const Text('General'),
                      onTap: () {
                        categoryTitle = 'General';
                        ref.read(newsServiceProvider).selectCategory('general');
                        _future =
                            newsRepo.getNewsByCategory(newsRepo.generalNews);
                      },
                    ),
                    PopupMenuItem(
                      value: 'health',
                      child: const Text('Health'),
                      onTap: () {
                        categoryTitle = 'Health';
                        ref.read(newsServiceProvider).selectCategory('health');
                        _future =
                            newsRepo.getNewsByCategory(newsRepo.healthNews);
                      },
                    ),
                    PopupMenuItem(
                      value: 'entertainment',
                      child: const Text('Entertainment'),
                      onTap: () {
                        categoryTitle = 'Entertainment';
                        ref
                            .read(newsServiceProvider)
                            .selectCategory('entertainment');
                        _future = newsRepo
                            .getNewsByCategory(newsRepo.entertainmentNews);
                      },
                    ),
                    PopupMenuItem(
                      value: 'sports',
                      child: const Text('Sports'),
                      onTap: () {
                        categoryTitle = 'Sports';
                        ref.read(newsServiceProvider).selectCategory('sports');
                        _future =
                            newsRepo.getNewsByCategory(newsRepo.sportsNews);
                      },
                    ),
                    PopupMenuItem(
                      value: 'business',
                      child: const Text('Business'),
                      onTap: () {
                        categoryTitle = 'Business';
                        ref
                            .read(newsServiceProvider)
                            .selectCategory('business');
                        _future =
                            newsRepo.getNewsByCategory(newsRepo.businessNews);
                      },
                    ),
                    PopupMenuItem(
                      value: 'science',
                      child: const Text('Science'),
                      onTap: () {
                        categoryTitle = 'Science';
                        ref.read(newsServiceProvider).selectCategory('science');
                        _future =
                            newsRepo.getNewsByCategory(newsRepo.scienceNews);
                      },
                    ),
                    PopupMenuItem(
                      value: 'technology',
                      child: const Text('Technology'),
                      onTap: () {
                        categoryTitle = 'Technology';
                        ref
                            .read(newsServiceProvider)
                            .selectCategory('technology');
                        _future =
                            newsRepo.getNewsByCategory(newsRepo.technologyNews);
                      },
                    ),
                  ],
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      _selectedValue = value;
                    });
                  }
                });
              },
              icon: const Icon(Icons.filter_alt)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                return MyGridView(list: snapshot.data!);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )),
        ],
      ),
    );
  }
}
