import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/modals/category.dart';
import 'package:littlefont_app/modals/note.dart';

class CategoryRepository extends ChangeNotifier {
  List<Category> category = [
    Category(categoryName: 'Job'),
    Category(categoryName: 'School'),
    Category(categoryName: 'Meeting')
  ];

  void addCategory(String categoryName) {
    category.add(Category(categoryName: categoryName));
    notifyListeners();
  }

  void removeCategory(int index) {
    category.removeAt(index);
    notifyListeners();
  }

  void removeNote(Category category, Notes note) {
    category.notes.remove(note);
    notifyListeners();
  }

  void addNote(Category category, Notes note) {
    category.notes.add(note);
    notifyListeners();
  }

  void noteOperation(int indexCategory, Notes value) {
    if (category[indexCategory].notes.contains(value)) {
      removeNote(category[indexCategory], value);
    } else {
      addNote(category[indexCategory], value);
    }
    notifyListeners();
  }

  void removeNoteFromCategory(int indexCategory, Notes value) {
    category[indexCategory].notes.remove(value);
    notifyListeners();
  }
}

final categoryProvider = ChangeNotifierProvider((ref) {
  return CategoryRepository();
});


