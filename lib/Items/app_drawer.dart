import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:littlefont/Repository/notes_repository.dart';
import 'package:littlefont/Screens/app_main_page.dart';
import 'package:littlefont/Screens/favourites_page.dart';
import 'package:littlefont/Screens/my_notes_page.dart';
import 'package:littlefont/Screens/recycle_bin_page.dart';

class AppDrawer extends StatelessWidget {
  final NotesRepository notesRepository;

  const AppDrawer({Key? key, required this.notesRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                leading: const Icon(Icons.notes),
                title: const Text('Notlarım'),
                onTap: () {
                  Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyNotes(notesRepository: notesRepository),
                    ));

                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite_outlined),
                title: const Text('Favoriler'),
                onTap: () {
                  Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          FavouritesPage(notesRepository: notesRepository),
                    ));

                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Çöp Kutusu'),
                onTap: () {
                  Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          RecycleBin(notesRepository: notesRepository),
                    ));

                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Ayarlar'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        RecycleBin(notesRepository: notesRepository),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Hakkında'),
                onTap: () {
                  Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          RecycleBin(notesRepository: notesRepository),
                    ));

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
