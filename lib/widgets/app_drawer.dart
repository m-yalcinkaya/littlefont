import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/repository/weather_repository.dart';
import 'package:littlefont_app/screens/about_page.dart';
import 'package:littlefont_app/screens/category_page.dart';
import 'package:littlefont_app/screens/favourites_page.dart';
import 'package:littlefont_app/screens/my_notes_page.dart';
import 'package:littlefont_app/screens/profile_page.dart';
import 'package:littlefont_app/screens/recycle_bin_page.dart';
import 'package:littlefont_app/screens/weather_page.dart';
import 'package:littlefont_app/services/auth_service.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:weather_icons/weather_icons.dart';

import '../screens/first_screen.dart';
import '../utilities/weather_utils.dart';

class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);



  @override
  ConsumerState<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  bool isLoading = false;


  Widget profilImage() {
    final photoUrl = FirebaseAuth.instance.currentUser?.photoURL;

    if (photoUrl != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(photoUrl),
        maxRadius: 20,
      );
    }

    return const CircleAvatar(
      maxRadius: 20,
      child: Icon(Icons.person),
    );
  }


    Widget weatherSection(screenSize){
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            'https://i.pinimg.com/564x/42/63/08/426308190ad76024b14768444b049de9.jpg'
          )
        )
      ),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        leading: const Text(''),
        trailing: IconButton(onPressed: () {
          setState(() {
            isLoading = true;
          });
        }, icon: const Icon(WeatherIcons.refresh)),
        title: Column(
          children: [
            const SizedBox(height: 15,),
            Text(ref.watch(weatherRepository).data?.areaName ?? 'null', style: const TextStyle(color: Colors.white),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(weatherIcon(ref.watch(weatherRepository).data?.icon), color: Colors.white,),
                const SizedBox(width: 10,),
                Text(
                  '${ref.watch(weatherRepository).data?.currentTemp?.round()}\u00B0C',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 15,),
          ],
        ),
        onTap: () {
          Navigator.pop(context);
          PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const WeatherPage());
        },
      ),
    );
  }

  Widget buildFutureBuilder(WidgetRef ref, Size screenSize) {

    if(ref.watch(weatherRepository).data == null || (ref.watch(weatherRepository).data != null && isLoading == true)){
      isLoading = false;
      return FutureBuilder(
        future: ref.watch(weatherRepository).getWeather(ref.watch(weatherRepository).area),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Text('An error occurred: ${snapshot.error.toString()}');
          }else if(snapshot.hasData){
            ref.watch(weatherRepository).data = snapshot.data!;
            return weatherSection(screenSize);
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        },);
    }
    return weatherSection(screenSize);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 3 / 4,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/pexels-photo-1563356.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
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
                            child: profilImage()),
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
            buildFutureBuilder(ref, screenSize),
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
                try {
                  await signOut(context);
                  await Future.microtask(
                    () {
                      Navigator.of(context, rootNavigator: true)
                          .pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const FirstScreen();
                          },
                        ),
                        (_) => false,
                      );
                    },
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('$e')));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
