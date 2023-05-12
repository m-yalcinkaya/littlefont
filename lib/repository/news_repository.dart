import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/services/news_service.dart';

import '../modals/news.dart';

class NewsRepository extends ChangeNotifier {
  final NewsService newsService;
  late String selectedValue;

  NewsRepository(this.newsService);

  List<News> list = [];

  List<News> generalNews = [];
  List<News> healthNews = [];
  List<News> entertainmentNews = [];
  List<News> sportsNews = [];
  List<News> businessNews = [];
  List<News> scienceNews = [];
  List<News> technologyNews = [];



  Future<void> getNewsByCategory(List<News> newsList) async {
    if (newsList == generalNews) {
      generalNews = [];
      final item = await newsService.getNews();
      generalNews.addAll(item);
    } else if (newsList == healthNews) {
      healthNews = [];
      final item = await newsService.getNews();
      healthNews.addAll(item);
    } else if (newsList == entertainmentNews) {
      entertainmentNews = [];
      final item = await newsService.getNews();
      entertainmentNews.addAll(item);
    } else if (newsList == sportsNews) {
      sportsNews = [];
      final item = await newsService.getNews();
      sportsNews.addAll(item);
    } else if (newsList == businessNews) {
      businessNews = [];
      final item = await newsService.getNews();
      businessNews.addAll(item);
    } else if (newsList == scienceNews) {
      scienceNews = [];
      final item = await newsService.getNews();
      scienceNews.addAll(item);
    } else if (newsList == technologyNews) {
      technologyNews = [];
      final item = await newsService.getNews();
      technologyNews.addAll(item);
    } else {
      generalNews = [];
      final item = await newsService.getNews();
      generalNews.addAll(item);
    }
    notifyListeners();
  }
}




final newsProvider = ChangeNotifierProvider((ref) {
  return NewsRepository(ref.read(newsServiceProvider));
});
