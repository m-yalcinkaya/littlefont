import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:littlefont/repository/accounts_repository.dart';
import 'package:littlefont/screens/about_page.dart';
import 'package:littlefont/screens/category_page.dart';
import 'package:littlefont/screens/favourites_page.dart';
import 'package:littlefont/screens/first_screen.dart';
import 'package:littlefont/screens/my_notes_page.dart';
import 'package:littlefont/screens/recycle_bin_page.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountRepo = ref.read(accountProvider);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
      child: SizedBox(
        width: 200,
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
                child: Column(
                  children: [
                    const Icon(
                      Icons.access_time_filled,
                      color: Colors.white,
                      size: 80,
                    ),
                    Text(
                      'LittleFont',
                      style: GoogleFonts.akshar(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const CircleAvatar(
                  maxRadius: 20,
                  child: Icon(
                    Icons.account_circle_rounded,
                    size: 40,
                  ),
                ),
                title: Text(
                    '${accountRepo.manager.name} ${accountRepo.manager.surname}'),
              ),
              const Divider(thickness: 5),
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
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const FirstScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
