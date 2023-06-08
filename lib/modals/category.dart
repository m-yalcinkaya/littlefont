import 'package:flutter/material.dart';
import 'package:littlefont_app/modals/note.dart';

class Category extends ChangeNotifier {
  String categoryName;

  List<Notes> notes = [];

  Category({required this.categoryName});
}