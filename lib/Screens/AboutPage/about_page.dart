import 'about_page_index.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hakkında'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 23,
            ),
            const Text(
              'LittleFont',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'LittleFont, kullanıcıların günlük notlarını, fikirlerini, hatırlatmalarını ve daha fazlasını kolayca kaydedebilecekleri kullanıcı dostu bir mobil not alma uygulamasıdır. littlefont, kullanıcıların günlük hayatlarını daha düzenli ve verimli hale getirmelerine yardımcı olmak için tasarlanmıştır.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Geliştirici Hakkında',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red, width: 5),
                  ),
                  child: const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/profil_image.jpg'),
                    radius: 50,
                    backgroundColor: Colors.blue,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                const Text(
                  'Mustafa Yalçınkaya',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                  'Selçuk Üniversitesi Bilgisayar Mühendisliği 2.sınıf öğrencisiyim. '
                  'bu proje benim flutter da ilk geliştirdiğim proje. Umarım faydalananlar olur.'),
            ),
          ],
        ),
      ),
    );
  }
}
