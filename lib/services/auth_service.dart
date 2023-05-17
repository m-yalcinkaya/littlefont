import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> createUser(BuildContext context,String firstName,String lastName, String emailAddress, String password) async {
  try {
    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    final User? user = userCredential.user;
    if (user != null) {
      await user.updateDisplayName('$firstName $lastName');
    }

  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('The password provided is too weak: $e')));
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('The account already exists for that email: $e')));
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occured. Please try again later: $e')));
  }
}