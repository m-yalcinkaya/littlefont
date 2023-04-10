class NotesRepository {
  List<Notes> notes = [
    Notes(title: 'Okul Okul Okul', content: 'Okul Metni'),
    Notes(title: 'Hastane', content: 'Hastane Metni'),
    Notes(title: 'Kreş', content: 'Kreş Metni'),
    Notes(title: 'Anasınıfı', content: 'Anasınıfı Metni'),
  ];

  List<Notes> favourites = [];

}

class Notes {
  final String title;
  final String content;

  Notes({required this.title, required this.content});
}
