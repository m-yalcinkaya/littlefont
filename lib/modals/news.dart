class News {
  final String title;
  final String content;
  final String urlToImage;

  News({required this.title, required this.content, required this.urlToImage});

  News.fromJson(Map<String, dynamic> m)
      : this(title: m["title"], content: m["content"], urlToImage: m["urlToImage"]);

  Map<String, String> toJson(News news) {
    final result = {"title": news.title, "content": news.content, "urlToImage": news.urlToImage};
    return result;
  }
}

