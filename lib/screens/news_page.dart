import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/repository/news_repository.dart';

import '../widgets/my_grid_view.dart';
import '../modals/news.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage> {
  late Future<List<News>?> _future;
  late String categoryTitle;
  // ignore: unused_field
  late String _selectedValue;

  @override
  void initState() {
    _selectedValue = 'general';
    categoryTitle = 'General';
    _future = ref
        .read(newsProvider)
        .getNewsByCategory('general', ref.read(newsProvider).generalNews);
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
                        _future =
                            newsRepo.getNewsByCategory('general' ,newsRepo.generalNews);
                      },
                    ),
                    PopupMenuItem(
                      value: 'health',
                      child: const Text('Health'),
                      onTap: () {
                        categoryTitle = 'Health';
                        _future =
                            newsRepo.getNewsByCategory('health' ,newsRepo.healthNews);
                      },
                    ),
                    PopupMenuItem(
                      value: 'entertainment',
                      child: const Text('Entertainment'),
                      onTap: () {
                        categoryTitle = 'Entertainment';
                        _future = newsRepo
                            .getNewsByCategory('entertainment', newsRepo.entertainmentNews);
                      },
                    ),
                    PopupMenuItem(
                      value: 'sports',
                      child: const Text('Sports'),
                      onTap: () {
                        categoryTitle = 'Sports';
                        _future =
                            newsRepo.getNewsByCategory('sports', newsRepo.sportsNews);
                      },
                    ),
                    PopupMenuItem(
                      value: 'business',
                      child: const Text('Business'),
                      onTap: () {
                        categoryTitle = 'Business';
                        _future =
                            newsRepo.getNewsByCategory('business',newsRepo.businessNews);
                      },
                    ),
                    PopupMenuItem(
                      value: 'science',
                      child: const Text('Science'),
                      onTap: () {
                        categoryTitle = 'Science';
                        _future =
                            newsRepo.getNewsByCategory('science', newsRepo.scienceNews);
                      },
                    ),
                    PopupMenuItem(
                      value: 'technology',
                      child: const Text('Technology'),
                      onTap: () {
                        categoryTitle = 'Technology';
                        _future =
                            newsRepo.getNewsByCategory('technology', newsRepo.technologyNews);
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
