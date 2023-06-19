
class Notes {
  final int? id;
  final String title;
  final String content;
  int isFavourite = 0;

  Notes({this.id ,required this.title, required this.content, required this.isFavourite});

  factory Notes.fromJson(Map<String, dynamic> map) {
    return Notes(
      id:  map['id'],
      title: map['title'],
      content: map['content'],
      isFavourite: map['isFavourite']
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      'title': title,
      'content': content,
      'isFavourite': isFavourite
    };

    map.removeWhere((key, value) => value == null);
    return map;
  }

}
