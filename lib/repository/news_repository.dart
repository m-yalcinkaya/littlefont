import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/services/news_service.dart';

import '../modals/news.dart';

class NewsRepository extends ChangeNotifier {
  final NewsService newsService;

  NewsRepository(this.newsService);

  List<News>? newsList = [];
  List<News>? generalNews = [];
  List<News>? healthNews = [];
  List<News>? entertainmentNews = [];
  List<News>? sportsNews = [];
  List<News>? businessNews = [];
  List<News>? scienceNews = [];
  List<News>? technologyNews = [];



  Future<List<News>?> getNewsByCategory(String category, List<News>? newsList) async {
    if (newsList == generalNews) {
      generalNews = [];
      final item = await newsService.getNews(category);
      generalNews!.addAll(item);
      return generalNews;
    } else if (newsList == healthNews) {
      healthNews = [];
      final item = await newsService.getNews(category);
      healthNews!.addAll(item);
      return healthNews;
    } else if (newsList == entertainmentNews) {
      entertainmentNews = [];
      final item = await newsService.getNews(category);
      entertainmentNews!.addAll(item);
      return entertainmentNews;
    } else if (newsList == sportsNews) {
      sportsNews = [];
      final item = await newsService.getNews(category);
      sportsNews!.addAll(item);
      return sportsNews;
    } else if (newsList == businessNews) {
      businessNews = [];
      final item = await newsService.getNews(category);
      businessNews!.addAll(item);
      return businessNews;
    } else if (newsList == scienceNews) {
      scienceNews = [];
      final item = await newsService.getNews(category);
      scienceNews!.addAll(item);
      return scienceNews;
    } else if (newsList == technologyNews) {
      technologyNews = [];
      final item = await newsService.getNews(category);
      technologyNews!.addAll(item);
      return technologyNews;
    }
    notifyListeners();
    return null;
  }
}



final newsProvider = ChangeNotifierProvider((ref) {
  return NewsRepository(ref.read(newsServiceProvider));
});
