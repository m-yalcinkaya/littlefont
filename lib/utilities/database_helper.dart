import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../modals/note.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      Create table notes(
        id INTEGER PRİMARY KEY,
        title NCHAR(50),
        content TEXT
      )
      ''');


    Future<List<Notes>> getNotes() async {
      Database db = await instance.database;
      var notes = await db.query('notes', orderBy: 'id');
      List<Notes> noteList = notes.isNotEmpty
        ? notes.map((e) => Notes.fromJson(e)).toList()
        : [];
      return noteList;
    }

    Future<int> add(Notes note) async {
      Database db = await instance.database;
      return await db.insert('notes', note.toMap());
    }

    Future<int> remove(int id) async {
      Database db = await instance.database;
      return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
    }

    Future<int> update(Notes note) async {
      Database db = await instance.database;
      return await db.update('notes' ,note.toMap(), where: 'id = ?', whereArgs: [note.id]);
    }

  }
}
