import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../modals/news.dart';

class NewsService {

  Future<List<News>> getNews(String category) async {
    final response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=b8bb19f553514c5fb4ed8727df8749b7'));
    final result = jsonDecode(response.body);
    List<News> j = [];
    if (response.statusCode == 200) {
      for (final m in result["articles"]) {
        News news = News.fromJson(m);
        j.add(news);
      }
      return j;
    } else {
      throw Exception('Couldn\'t was downloaded news');
    }
  }
}

final newsServiceProvider = Provider((ref) {
  return NewsService();
});
