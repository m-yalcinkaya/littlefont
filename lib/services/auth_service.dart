import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:littlefont/modals/account.dart';

import '../screens/first_screen.dart';
import '../widgets/bottom_nav_bar.dart';

Future<void> createUser(BuildContext context,
    {required Account account}) async {
  try {
    final userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: account.email,
      password: account.password,
    );

    final User? user = userCredential.user;
    if (user != null) {
      await user.updateDisplayName('${account.firstName} ${account.lastName}');
    }
    await FirebaseAuth.instance.setLanguageCode('en');
    await user?.sendEmailVerification();
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('The password provided is too weak: $e')));
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('The account already exists for that email: $e')));
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occured. Please try again later: $e')));
  }
}

Future<void> logInUser(
    BuildContext context, String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    await Future.microtask(
      () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const BottomNavBar(),
        ));
      },
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user found for that email: $e')));
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Wrong password provided for that user: $e')));
    }
  }
}

Future<void> signOut(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();

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
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An Error Occurred While Logging Out: $e')));
  }
}
