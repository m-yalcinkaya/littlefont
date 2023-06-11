import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/screens/first_screen.dart';
import 'package:littlefont_app/widgets/bottom_nav_bar.dart';

import 'config/firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget goToAppScreen() {
    if (FirebaseAuth.instance.currentUser != null) {
      return const BottomNavBar();
    } else {
      return const FirstScreen();
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LittleFont',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: goToAppScreen(),
    );
  }
}

