import 'package:flutter/material.dart';

class Notes {
  final String title;
  final String content;
  Color color = const Color.fromARGB(200, 200, 250, 220);

  Notes({required this.title, required this.content});
}