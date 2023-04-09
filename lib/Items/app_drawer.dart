import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:littlefont/Screens/my_notes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

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
                    image: AssetImage('assets/images/pexels-photo-1563356.jpg',),
                    fit: BoxFit.fill,
                  ),
                  color: Colors.red,
                ),
                child: Column(
                  children:  [
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
                leading:const Icon(Icons.home),
                title: const Text('Anasayfa'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MyNotes(),));
                },
              ),
              ListTile(
                leading: const Icon(Icons.notes),
                title: const Text('Notlarım'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MyNotes(),));
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite_outlined),
                title: const Text('Favoriler'),
                onTap: () {
                  // Profil sayfasına git
                },
              ),

              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Ayarlar'),
                onTap: () {

                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Hakkında'),
                onTap: () {

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
