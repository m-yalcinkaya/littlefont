import 'package:flutter/material.dart';

class NotesRepository {
  List<Notes> notes = [];

  List<Notes> favourites = [];

  List<Notes> recycle = [];

  String recyleInfo =
      'Sildiğin notlar tamamen silinene kadar 30 gün çöp kutusunda kalır.';

  List<Category> category = [];

  addCategory(String categoryName) {
    category.add(Category(categoryName: categoryName));
  }
}

class Notes {
  final String title;
  final String content;
  Color color = const Color.fromARGB(200, 200, 250, 220);

  Notes({required this.title, required this.content});
}

class Category {

  String categoryName;

  List<Notes> notes = [];

  Category({required this.categoryName});
}
