import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/screens/about_page.dart';
import 'package:littlefont/screens/category_page.dart';
import 'package:littlefont/screens/favourites_page.dart';
import 'package:littlefont/screens/my_notes_page.dart';
import 'package:littlefont/screens/profile_page.dart';
import 'package:littlefont/screens/recycle_bin_page.dart';
import 'package:littlefont/services/auth_service.dart';

import '../screens/first_screen.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  ImageProvider profilImage() {
    final photoUrl = FirebaseAuth.instance.currentUser?.photoURL;
    if (photoUrl != null) {
      return NetworkImage(photoUrl);
    }
    return const AssetImage('assets/images/kuslar.jpg');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 3 / 4,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              curve: Curves.ease,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/pexels-photo-1563356.jpg',
                  ),
                  fit: BoxFit.fill,
                ),
                color: Colors.red,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ));
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                    child: Container(
                      color: Colors.white70,
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.red, width: 5),
                          ),
                          child: CircleAvatar(
                            backgroundImage: profilImage(),
                            maxRadius: 20,
                          ),
                        ),
                        title: AutoSizeText(
                            '${FirebaseAuth.instance.currentUser?.displayName}'),
                        subtitle: AutoSizeText(
                            FirebaseAuth.instance.currentUser?.email ?? ''),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.notes),
              title: const Text('My Notes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyNotes(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Categories'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CategoryPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Favourites'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FavouritesPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Recycle Bin'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RecycleBin(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AboutPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () async {
                Navigator.pop(context);
                try{
                  await signOut(context);
                  await Future.microtask(
                        () {
                      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const FirstScreen();
                          },
                        ),
                            (_) => false,
                      );
                    },
                  );
                }catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
