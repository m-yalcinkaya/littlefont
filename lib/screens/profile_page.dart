import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


class ProfilePage extends ConsumerStatefulWidget{
  const ProfilePage({Key? key}) : super(key: key);


  @override
  ConsumerState<ProfilePage> createState() => _LoginState();
}

class _LoginState extends ConsumerState<ProfilePage> {

  final ImagePicker _picker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;


  Widget profilImage(double radius) {
    final photoUrl = FirebaseAuth.instance.currentUser?.photoURL;

    if (photoUrl != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(photoUrl),
        maxRadius: radius,
      );
    }

    return CircleAvatar(
      backgroundColor: Colors.red,
      maxRadius: radius,
      child: Icon(Icons.person, size: radius,color: Colors.white),
    );
  }




  Future<void> _onImageButtonPressed(ImageSource source, {
    required BuildContext context,
  }) async {
    if (context.mounted) {
      try {
        final XFile? pickedFile = await _picker.pickImage(
          maxWidth: 1024,
          maxHeight: 1024,
          imageQuality: 85,
          source: source,
        );
        setState(() {
          _setImageFileListFromFile(pickedFile);
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An Error Occured : $e')));
      }
    }
  }


  Future<void> _setImageFileListFromFile(XFile? file) async {
    if (file == null) return;
    try {
      File imageFile = File(file.path);
      String fileName = basename(imageFile.path);
      Reference storageRef = storage.ref().child(fileName);

      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      setState(() {
        FirebaseAuth.instance.currentUser?.updatePhotoURL(downloadURL);
        FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.email).update({
          'photoUrl': downloadURL,
        });
      });
    } catch (e) {
      setState(() {
        throw Exception('An error occured while loading the message to storage');
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: screenSize.height*1/6,
                    width: screenSize.width,
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.fromBorderSide(BorderSide(
                            color: Colors.red,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            width: 5,
                          ))
                      ),
                      child: const Image(
                          fit: BoxFit.cover,
                          image: NetworkImage('https://www.fotografindir.net/wp-content/uploads/2019/09/en-guzel-deniz-manzaralari.jpg')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.6),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.red, width: 5),
                          ),
                          child: profilImage(80)
                      ),
                    ),
                  ),

                ],
              ),

              Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    FirebaseAuth.instance.currentUser!.displayName ?? 'null',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  )),

              Text(
                FirebaseAuth.instance.currentUser!.email ?? 'null',
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Positioned(
            top: 150,
            left: 300,
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      children: [
                        SimpleDialogOption(
                          onPressed: () {
                            _onImageButtonPressed(ImageSource.gallery, context: context);
                            Navigator.of(context).pop();
                          },
                          child: const Row(
                              children: [
                                Icon(Icons.photo),
                                SizedBox(width: 10,),
                                Text('Gallery')
                              ]),),
                        SimpleDialogOption(
                          onPressed: () {
                            _onImageButtonPressed(ImageSource.camera, context: context);
                            Navigator.of(context).pop();
                          },
                          child: const Row(
                              children: [
                                Icon(Icons.camera),
                                SizedBox(width: 10,),
                                Text('Camera')
                              ]),),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.change_circle_rounded, color: Colors.black, size: 30,),
            ),
          ),
        ],

      ),
    );
  }
}
