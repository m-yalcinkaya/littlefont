import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../modals/news.dart';

class NewsService {
  final String url =
      'https://newsapi.org/v2/everything?q=bitcoin&apiKey=28275833cd7b49c09e7a3b111248cbc4';

  Future<List<News>> getNews() async {
    final response = await http.get(Uri.parse(url));
    final result = jsonDecode(response.body);
    List<News> j = [];
    if (response.statusCode == 200) {
      for (final m in result["articles"]) {
        News news = News.fromJson(m);
        j.add(news);
      }
      return j;
    } else {
      throw Exception('Haber indirilemedi!!');
    }
  }
}

final newsServiceProvider = Provider((ref) {
  return NewsService();
});

