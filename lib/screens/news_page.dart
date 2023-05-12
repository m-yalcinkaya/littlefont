import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/repository/news_repository.dart';

import '../items/my_grid_view.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage> {
  bool isLoading = false;

  List<String> newsCategories = [
    'general',
    'health',
    'entertainment',
    'sports',
    'business',
    'science',
    'technology'
  ];


  void findCategoryList(NewsRepository newsRepo){
    switch(newsRepo.selectedValue){
      case 'general': newsRepo.list = newsRepo.generalNews;break;
      case 'health': newsRepo.list = newsRepo.healthNews;break;
      case 'entertainment': newsRepo.list = newsRepo.entertainmentNews;break;
      case 'sports': newsRepo.list = newsRepo.sportsNews;break;
      case 'business': newsRepo.list = newsRepo.businessNews;break;
      case 'science': newsRepo.list = newsRepo.scienceNews;break;
      case 'technology': newsRepo.list = newsRepo.technologyNews;break;
    }
  }

  @override
  void initState() {
    ref.read(newsProvider).selectedValue = 'general';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newsRepo = ref.watch(newsProvider);
    findCategoryList(newsRepo);
    return Scaffold(
      appBar: AppBar(
        title: const Text('LittleFont News'),
        actions: [
          DropdownButton(
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
                newsRepo.selectedValue = value!;
              });
            },
          ),
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
                    'Total Results: ${ref.read(newsProvider).list.length}')),
          ),
          const Expanded(
            child: MyGridView(),
          ),
        ],
      ),
    );
  }
}
