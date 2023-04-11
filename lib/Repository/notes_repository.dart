import 'package:flutter/material.dart';

class NotesRepository {
  List<Notes> notes = [
    Notes(title: 'Kitap Listesi', content: 'Okunacak kitaplar: "1984" - George Orwell, "Harry Potter ve Felsefe Taşı" - J.K. '),
    Notes(title: 'Randevular', content: 'Doktor randevusu: 15 Nisan, 14:30, adres: XYZ Hastanesi, Dr. Ayşe Bey'),
    Notes(title: 'Notlar', content: 'Sunum notları: Başlık slaytında vurgulanması gereken noktalar'),
    Notes(title: 'Alışveriş Listesi', content: 'Süt, ekmek, yumurta, meyve'),
    Notes(title: 'Okul Listesi', content: 'Defter, kalem, fon kağıdı, meyve'),
  ];




  List<Notes> favourites = [];

  List<Notes> recycle = [];

  String recyleInfo = 'Sildiğin notlar tamamen silinene kadar 30 gün çöp kutusunda kalır.';

}




class Notes {
  final String title;
  final String content;
  Color color = const Color.fromARGB(200, 200, 250, 220);

  Notes({required this.title, required this.content});
}
