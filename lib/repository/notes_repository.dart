import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/modals/note.dart';

import '../utilities/database_helper.dart';

class NotesRepository extends ChangeNotifier {
  List<Notes> notes = [];

  List<Notes> favourites = [];

  List<Notes> recycle = [];

  String recycleInfo =
      'Deleted notes are kept in the recycle bin for 30 days until you delete them completely.';


  Future<void> addNote(Notes note) async {
    await DatabaseHelper.instance.insertNote(note);
    notifyListeners();
  }

  Future<void> addFavourite(Notes note) async {
    await DatabaseHelper.instance.insertFavourite(note);
    note.isFavourite = 1;
    updateNote(note);
    notifyListeners();
  }

  Future<void> addRecycle(Notes note) async {
    await DatabaseHelper.instance.insertRecycle(note);
    notifyListeners();
  }

  Future<void> removeNote(Notes note) async {
    await DatabaseHelper.instance.deleteNote(note.id!);
    notifyListeners();
  }

  Future<void> removeFavourite (Notes note) async {
    await DatabaseHelper.instance.deleteFavourite(note.id!);
    note.isFavourite = 0;
    updateNote(note);
    notifyListeners();
  }

  Future<void> removeRecycle(Notes note) async {
    await DatabaseHelper.instance.deleteRecycle(note.id!);
    notifyListeners();
  }

  Future<void> updateNote(Notes note) async {
    await DatabaseHelper.instance.renewNote(note);
    notifyListeners();
  }

}

final notesProvider = ChangeNotifierProvider((ref) {
  return NotesRepository();
});


