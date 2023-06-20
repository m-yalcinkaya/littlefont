import 'dart:io';

import 'package:littlefont_app/modals/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../modals/category.dart';
import '../repository/notes_repository.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentDirectory.path, 'note25.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(notes);
    await db.execute(favourites);
    await db.execute(recycle);
    await db.execute(categories);
    await db.execute(categoryNotes);

  }

  static const notes = '''
  CREATE TABLE IF NOT EXISTS notes(
      id INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      isFavourite INTEGER NOT NULL
  );
  ''';

  static const favourites = ''' 
  CREATE TABLE IF NOT EXISTS favourites(
      favourite_id INTEGER PRIMARY KEY,
      id INTEGER,
      FOREIGN KEY (id) REFERENCES notes(id)
  );
  ''';

  static const recycle = '''
  CREATE TABLE IF NOT EXISTS recycle(
      id INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      isFavourite INTEGER NOT NULL);
  ''';

  static const categories = ''' 
  CREATE TABLE IF NOT EXISTS categories(
      id INTEGER PRIMARY KEY,
      category_name TEXT NOT NULL
  );
  ''';

  static const categoryNotes = ''' 
  CREATE TABLE IF NOT EXISTS category_notes(
      id INTEGER PRIMARY KEY,
      category_id INTEGER,
      note_id INTEGER,
      FOREIGN KEY (note_id) REFERENCES notes(id),
      FOREIGN KEY (category_id) REFERENCES categories(id)
  );
  ''';

  Future<List<NoteCategory>> getCategories() async {
    Database db = await instance.database;
    var notes = await db.rawQuery('SELECT * FROM categories');
    List<NoteCategory> noteList = notes.isNotEmpty ? notes.map((e) => NoteCategory.fromJson(e)).toList() : [];
    return noteList;
  }

  Future<List<Notes>> getCategoryNotes(int id) async {
    Database db = await instance.database;
    var notes = await db.rawQuery('SELECT * FROM category_notes where category_id = $id');
    List<Notes> noteList = notes.isNotEmpty ? notes.map((e) => Notes.fromJson(e)).toList() : [];
    return noteList;
  }

  Future<int> deleteCategoryNote(int noteID, int categoryID) async {
    Database db = await instance.database;
    return await db.rawDelete('DELETE FROM categories_note WHERE note_id = ? AND category_id = ?', [noteID, categoryID]);
  }



  Future<bool?> isFounded(String value) async {
    Database db = await instance.database;
    var notes = await db.rawQuery('SELECT * FROM categories where category_name = "$value"');
    if(notes.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }


  Future<List<Notes>> getNotes() async {
    Database db = await instance.database;
    var notes = await db.rawQuery('SELECT * FROM notes');
    List<Notes> noteList = notes.isNotEmpty ? notes.map((e) => Notes.fromJson(e)).toList() : [];
    return noteList;
  }

  Future<List<Notes>> getFavourites() async {
    Database db = await instance.database;
    var notes = await db.rawQuery('SELECT * FROM notes WHERE id IN (SELECT id FROM favourites)');
    List<Notes> noteList = notes.isNotEmpty ? notes.map((e) => Notes.fromJson(e)).toList() : [];
    return noteList;
  }

  Future<List<Notes>> getRecycle() async {
    Database db = await instance.database;
    var notes = await db.rawQuery('select *from recycle');
    List<Notes> noteList = notes.isNotEmpty ? notes.map((e) => Notes.fromJson(e)).toList() : [];
    return noteList;
  }

  Future<bool> isContain(NotesRepository noteReadRepo, int index) async {
    Database db = await instance.database;
    final value = noteReadRepo.notes[index].id;
    if (value != null) {
      var foundedValue = await db.rawQuery('SELECT * FROM favourites WHERE id = ?', [value]);
      if(foundedValue.isNotEmpty){
        return true;
      }else {
        return false;
      }
    }
    return false;
  }


  Future<int> insertCategory(NoteCategory category) async {
    Database db = await instance.database;
    return await db.insert('categories', category.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }


  Future<int> deleteCategory(int id) async {
    Database db = await instance.database;
    return await db.rawDelete('DELETE FROM categories WHERE id = ?', [id]);
  }


  Future<int> insertNote(Notes note) async {
    Database db = await instance.database;
    return await db.insert('notes', note.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> insertFavourite(Notes note) async {
    Database db = await instance.database;
    return await db.insert('favourites', {'id': note.id}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> insertRecycle(Notes note) async {
    Database db = await instance.database;
    return await db.insert('recycle', note.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> deleteNote(int id) async {
    Database db = await instance.database;
    return await db.rawDelete('DELETE FROM notes WHERE id = ?', [id]);
  }

  Future<int> deleteFavourite(int id) async {
    Database db = await instance.database;
    return await db.rawDelete('DELETE FROM favourites WHERE id = ?', [id]);
  }

  Future<int> deleteRecycle(int id) async {
    Database db = await instance.database;
    return await db.rawDelete('DELETE FROM recycle WHERE id = ?', [id]);
  }

  Future<int> renewNote(Notes note) async {
    Database db = await instance.database;
    return await db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }
}
