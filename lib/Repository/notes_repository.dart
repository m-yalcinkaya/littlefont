import 'dart:math';
import 'package:flutter/material.dart';

class NotesRepository {
  List<Notes> notes = [
    Notes(title: 'Okul Okul Okul', content: 'Okul Metni'),
    Notes(title: 'Hastane', content: 'Hastane Metni'),
    Notes(title: 'Kreş', content: 'Kreş Metni'),
    Notes(title: 'Anasınıfı', content: 'Anasınıfı Metni'),
  ];

  List<Notes> favourites = [];

  List<Notes> recycle = [];

  String recyleInfo = 'Sildiğin notlar tamamen silinene kadar 30 gün çöp kutusunda kalır.';

}

List<Color> colors = [Colors.red.shade100, Colors.blue.shade100, Colors.green.shade100];


class Notes {
  final String title;
  final String content;
  Color color = colors[Random().nextInt(3)];

  Notes({required this.title, required this.content});
}
