
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/modals/category.dart';
import 'package:littlefont_app/modals/note.dart';

import '../utilities/database_helper.dart';

class CategoryRepository extends ChangeNotifier {
  List<NoteCategory> category = [];
  List<Notes> notes = [];


  Future<void> updateCategory() async {
    category = await DatabaseHelper.instance.getCategories();
    notifyListeners();
  }

  Future<void> getCategories() async {
    await DatabaseHelper.instance.getCategories();
    notifyListeners();
  }

  Future<void> getCategoryNotes(int id) async {
    await DatabaseHelper.instance.getCategoryNotes(id);
    notifyListeners();
  }


  Future<void> addCategory(NoteCategory category) async {
    await DatabaseHelper.instance.insertCategory(category);
    notifyListeners();
  }

  Future<void> removeCategory(NoteCategory category) async {
    await DatabaseHelper.instance.deleteCategory(category.id!);
    notifyListeners();
  }

  Future<void> deleteCategoryNote(Notes note,NoteCategory category) async {
    await DatabaseHelper.instance.deleteCategoryNote(note.id!, category.id!);
    notifyListeners();
  }

  Future<void> insertToCategory(Notes note,NoteCategory category) async {
    await DatabaseHelper.instance.insertToCategory(category, note);
    notifyListeners();
  }


 /* void removeNote(NoteCategory category, Notes note) {
    category.notes.remove(note);
    notifyListeners();
  }

  void addNote(NoteCategory category, Notes note) {
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
  }*/
}

final categoryProvider = ChangeNotifierProvider((ref) {
  return CategoryRepository();
});


