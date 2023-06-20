
class NoteCategory {
  final int? id;
  final String categoryName;

  NoteCategory({this.id, required this.categoryName});

  factory NoteCategory.fromJson(Map<String, dynamic> map) {
    return NoteCategory(
        id:  map['id'],
      categoryName: map['category_name']
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "category_name": categoryName,
    };

    map.removeWhere((key, value) => value == null);
    return map;
  }
}