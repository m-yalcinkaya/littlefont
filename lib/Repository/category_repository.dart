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

  void removeNote (Category category, Notes note) {
    category.notes.remove(note);
    notifyListeners();
  }

  void addNote (Category category, Notes note) {
    category.notes.add(note);
    notifyListeners();
  }

}


final categoryProvider = ChangeNotifierProvider((ref) {
  return CategoryRepository();
});



class Category extends ChangeNotifier{

  String categoryName;

  List<Notes> notes = [];

  Category({required this.categoryName});
}
