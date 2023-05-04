import 'about_page_index.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
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
              'LittleFont is a user-friendly mobile application where users can easily follow current news, chat with friends, save, publish and share daily notes, ideas, reminders and more. littlefont is designed to help users make their daily life more organized and efficient.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'About Developer',
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
                  'I am a 2nd year Computer Engineering student at Selcuk University. '
                  'this project is the first project i developed in flutter. I hope they will benefit.'),
            ),
          ],
        ),
      ),
    );
  }
}
