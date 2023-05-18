import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:littlefont/widgets/bottom_nav_bar.dart';

import 'app_main_page.dart';
import 'first_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isInitializedFirebase = false;

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    setState(() {
      isInitializedFirebase = true;
    });
  }

  Widget goToAppScreen() {
    if(FirebaseAuth.instance.currentUser != null){
      return const BottomNavBar();
    }else {
      return const FirstScreen();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: !isInitializedFirebase
            ? const Center(child: CircularProgressIndicator())
            : goToAppScreen());
  }
}
