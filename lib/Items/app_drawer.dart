import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:littlefont/Repository/notes_repository.dart';
import 'package:littlefont/Screens/AboutPage/about_page.dart';
import 'package:littlefont/Screens/CategoryPage/category_page.dart';
import 'package:littlefont/Screens/FavouritesPage/favourites_page.dart';
import 'package:littlefont/Screens/FirstScreenPage/first_screen.dart';
import 'package:littlefont/Screens/MyNotesPage/my_notes_page.dart';
import 'package:littlefont/Screens/RecycleBinPage/recycle_bin_page.dart';

class AppDrawer extends StatefulWidget {
  final NotesRepository notesRepository;
  final String? name;
  final String? surname;

  const AppDrawer({
    Key? key,
    required this.notesRepository,
    this.name,
    required this.surname,
  }) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
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
              SizedBox(
                height: 100,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    const CircleAvatar(
                      maxRadius: 20,
                      child: Icon(
                        Icons.account_circle_rounded,
                        size: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${widget.name} ${widget.surname}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const ColoredBox(
                  color: Colors.black45, child: Divider(thickness: 15)),
              ListTile(
                leading: const Icon(Icons.notes),
                title: const Text('Notlarım'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        MyNotes(notesRepository: widget.notesRepository),
                  ));
                  setState(() {});
                },
              ),
              ListTile(
                leading: const Icon(Icons.category),
                title: const Text('Kategoriler'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        CategoryPage(notesRepository: widget.notesRepository),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Favoriler'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        FavouritesPage(notesRepository: widget.notesRepository),
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
                        RecycleBin(notesRepository: widget.notesRepository),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Hakkında'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Çıkış Yap'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const FirstScreen()),
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
