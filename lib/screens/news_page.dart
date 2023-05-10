import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/repository/news_repository.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LittleFont News'),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20) + const EdgeInsets.symmetric(vertical: 10),
                child: Text('Total Results: ${ref.read(newsProvider).news.length}')),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ref.watch(newsProvider).news.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: Image.network(ref.watch(newsProvider).news[index].urlToImage ?? 'https://cdn.pixabay.com/photo/2014/06/16/23/39/black-370118_960_720.png'),
                      title: Text(ref.watch(newsProvider).news[index].title),
                    ),
                    const Divider(thickness: 1),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
