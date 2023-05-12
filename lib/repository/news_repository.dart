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


  Future<void> showGeneralNews() async {
    final item = await newsService.getNews();
    generalNews = [];
    generalNews.addAll(item);
    notifyListeners();
  }

  Future<void> showHealthNews() async {
    final item = await newsService.getNews();
    healthNews = [];
    healthNews.addAll(item);
    notifyListeners();
  }

  Future<void> showEntertainmentNews() async {
    final item = await newsService.getNews();
    entertainmentNews = [];
    entertainmentNews.addAll(item);
    notifyListeners();
  }

  Future<void> showSportNews() async {
    final item = await newsService.getNews();
    sportsNews = [];
    sportsNews.addAll(item);
    notifyListeners();
  }

  Future<void> showBusinessNews() async {
    final item = await newsService.getNews();
    businessNews = [];
    businessNews.addAll(item);
    notifyListeners();
  }

  Future<void> showScienceNews() async {
    final item = await newsService.getNews();
    scienceNews = [];
    scienceNews.addAll(item);
    notifyListeners();
  }

  Future<void> showTechnologyNews() async {
    final item = await newsService.getNews();
    technologyNews = [];
    technologyNews.addAll(item);
    notifyListeners();
  }
}




final newsProvider = ChangeNotifierProvider((ref) {
  return NewsRepository(ref.read(newsServiceProvider));
});
