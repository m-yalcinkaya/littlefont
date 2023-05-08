import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/services/news_service.dart';

import '../modals/news.dart';

class NewsRepository extends ChangeNotifier {
  final NewsService newsService;

  NewsRepository(this.newsService);

  List<News> news = [];

  Future<void> showNews() async {
    final item = await newsService.getNews();
    news = [];
    news.addAll(item);
    notifyListeners();
  }
}

final newsProvider = ChangeNotifierProvider((ref) {
  return NewsRepository(ref.read(newsServiceProvider));
});
