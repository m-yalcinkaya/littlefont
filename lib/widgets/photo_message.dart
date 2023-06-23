import 'package:flutter/material.dart';

class PhotoMessage extends StatelessWidget {
  final String photo;
  const PhotoMessage({Key? key, required this.photo}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:  Center(child: Image.network(photo)),
    );
  }
}
