class News {
  final String? title;
  final String? content;
  final String? urlToImage;
  final String? author;
  final String? url;

  News({
    required this.title,
    required this.content,
    required this.urlToImage,
    required this.author,
    required this.url,
  });

  News.fromJson(Map<String, dynamic> m)
      : this(
          title: m["title"],
          content: m["content"],
          urlToImage: m["urlToImage"],
          author: m["author"],
          url: m["url"],
        );
}
