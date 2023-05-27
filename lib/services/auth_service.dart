import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:littlefont/modals/account.dart';

import '../screens/first_screen.dart';
import '../widgets/bottom_nav_bar.dart';



Future<void> createUser({required Account account}) async {
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

    FirebaseFirestore.instance.collection('users').doc(account.email).set({
      'firstName': account.firstName,
      'lastName': account.lastName,
      'email': account.email,
      'photoUrl': account.photoUrl,
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      throw Exception('The password provided is too weak');
    } else if (e.code == 'email-already-in-use') {
      throw Exception('The account already exists for that email');
    }
  } catch (e) {
    throw Exception('An error occured. Please try again later: $e');
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
      throw Exception('No user found for that email');
    } else if (e.code == 'wrong-password') {
      throw Exception('Wrong password provided for that user');
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
    throw Exception('An Error Occurred While Logging Out');
  }
}
