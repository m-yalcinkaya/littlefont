import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {

  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );


  List<String> words = googleUser!.displayName!.split(' ');
  final firstName = words[0];
  final lastName = words[1];


  FirebaseFirestore.instance.collection('users').doc(googleUser.email).set({
    'firstName': firstName,
    'lastName': lastName,
    'email': googleUser.email,
    'photoUrl': googleUser.photoUrl,
  });

  return await FirebaseAuth.instance.signInWithCredential(credential);
}

