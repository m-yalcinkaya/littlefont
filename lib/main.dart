import 'package:flutter/material.dart';
import 'Screens/first_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LittleFont',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: FirstScreen(title: 'Giriş Yap'),
    );
  }
}

