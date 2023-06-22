import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget{
  const ProfilePage({Key? key}) : super(key: key);


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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        child: Column(
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
                  padding: EdgeInsets.only(top: screenSize.height*50.6/821.4),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red, width: 5),
                      ),
                      child: Stack(
                          children: [
                            profilImage(screenSize.height*65/821.4),
                            const Positioned(
                              top: 90,
                              left: 75,
                              child: IconButton(
                                onPressed: null,
                                  icon: Icon(Icons.change_circle_rounded, color: Colors.white, size: 45,),
                              ),
                            ),
                          ],
                      )
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
      ),
    );
  }
}
