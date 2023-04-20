import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notes_repository.dart';

class CategoryRepository extends ChangeNotifier {

  List<Category> category = [
    Category(categoryName: 'İş'),
    Category(categoryName: 'Okul'),
    Category(categoryName: 'Toplantı')
  ];

  void addCategory(String categoryName) {
    category.add(Category(categoryName: categoryName));
    notifyListeners();
  }


  void removeCategory(int index){
    category.removeAt(index);
    notifyListeners();
  }
}

final categoryProvider = ChangeNotifierProvider((ref) {
  return CategoryRepository();
});



class Category extends ChangeNotifier{

  String categoryName;

  List<Notes> notes = [];

  void addNote (Notes note, List list) {
    list.add(note);
    notifyListeners();
  }

  void removeNote (Notes note, List list) {
    list.remove(note);
    notifyListeners();
  }

  Category({required this.categoryName});
}

