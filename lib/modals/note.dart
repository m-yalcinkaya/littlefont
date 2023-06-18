import 'package:flutter/material.dart';

class Notes {
  final int? id;
  final String title;
  final String content;
  Color color = const Color.fromARGB(200, 200, 250, 220);

  Notes({this.id ,required this.title, required this.content});

  factory Notes.fromJson(Map<String, dynamic> map) {
    return Notes(
      id:  map['id'],
      title: map['title'],
      content: map['content'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title': title,
      'content': content,
    };
  }
}
