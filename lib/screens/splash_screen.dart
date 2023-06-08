import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:littlefont/firebase_options.dart';
import 'package:littlefont/widgets/bottom_nav_bar.dart';

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
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      setState(() {
        isInitializedFirebase = true;
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('An error occurred when connecting to Firebase. Please try again later: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Widget firstWidget() {
    if (!isInitializedFirebase) {
      return const Center(child: CircularProgressIndicator());
    }
    return goToAppScreen();
  }

  Widget goToAppScreen() {
    if (FirebaseAuth.instance.currentUser != null) {
      return const BottomNavBar();
    } else {
      return const FirstScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FutureBuilder<void>(
      future: initializeFirebase(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return firstWidget();
        }
      },
    ));
  }
}

