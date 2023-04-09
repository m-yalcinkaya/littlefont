

class NotesRepository{
  List<Notes> notlar = [
    Notes(title: 'Okul', content: 'Okul Metni'),
    Notes(title: 'Hastane', content: 'Hastane Metni'),
    Notes(title: 'Kreş', content: 'Kreş Metni'),
    Notes(title: 'Anasınıfı', content: 'Anasınıfı Metni'),
  ];
}

class Notes{
  final String title;
  final String content;
  Notes({required this.title, required this.content});
}




