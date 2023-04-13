import 'package:flutter/material.dart';

class NotesRepository {
  List<Notes> notes = [
    Notes(
        title: 'Randevular',
        content:
            'Doktor randevusu: 15 Nisan, 14:30, adres: XYZ Hastanesi, Dr. Ayşe Bey'),
    Notes(
        title: 'Notlar',
        content:
            'Sunum notları: Başlık slaytında vurgulanması gereken noktalar'),
    Notes(title: 'Alışveriş Listesi', content: 'Süt, ekmek, yumurta, meyve'),
    Notes(title: 'Okul Listesi', content: 'Defter, kalem, fon kağıdı, meyve'),
    Notes(
        title: 'Yeni Proje Fikirleri',
        content:
            'Yaratıcı düşüncelerle dolu bir beyin fırtınası yaparak yeni proje fikirleri üretmeye başla. Ekip üyelerinden geri bildirim al ve ilham verici bir sunum hazırla.'),
    Notes(
        title: 'Tatil Planları',
        content:
            'Tatil sezonu yaklaşıyor! Uygun tarihleri belirle, konaklama ve ulaşım düzenlemelerini yap, keşfedilecek yerler hakkında araştırma yap ve tatil planlarını tamamla.'),
    Notes(
        title: 'Sağlıklı Yaşam',
        content:
            ' Daha sağlıklı bir yaşam tarzı için adımlar atmaya başla. Düzenli egzersiz yap, dengeli beslen, yeterli su iç ve stres yönetimi teknikleri uygula. Sağlıklı bir yaşam için hedefler belirle ve planlarını oluştur.'),
  ];

  List<Notes> favourites = [
    Notes(title: 'Okul Listesi', content: 'Defter, kalem, fon kağıdı, meyve'),
    Notes(
        title: 'Yeni Proje Fikirleri',
        content:
            'Yaratıcı düşüncelerle dolu bir beyin fırtınası yaparak yeni proje fikirleri üretmeye başla. Ekip üyelerinden geri bildirim al ve ilham verici bir sunum hazırla.'),
    Notes(
        title: 'Sağlıklı Yaşam',
        content:
            ' Daha sağlıklı bir yaşam tarzı için adımlar atmaya başla. Düzenli egzersiz yap, dengeli beslen, yeterli su iç ve stres yönetimi teknikleri uygula. Sağlıklı bir yaşam için hedefler belirle ve planlarını oluştur.'),
  ];

  List<Notes> recycle = [
    Notes(
        title: 'Kitap Listesi',
        content:
            'Okunacak kitaplar: "1984" - George Orwell, "Harry Potter ve Felsefe Taşı" - J.K. '),
  ];

  String recyleInfo =
      'Sildiğin notlar tamamen silinene kadar 30 gün çöp kutusunda kalır.';

  List<Category> category = [
    Category(categoryName: 'İş'),
    Category(categoryName: 'Okul'),
    Category(categoryName: 'Toplantı')
  ];

  addCategory(String categoryName) {
    category.add(Category(categoryName: categoryName));
  }
}

class Notes {
  final String title;
  final String content;
  Color color = const Color.fromARGB(200, 200, 250, 220);

  Notes({required this.title, required this.content});
}

class Category {
  String categoryName;

  List<Notes> notes = [];

  Category({required this.categoryName});
}
