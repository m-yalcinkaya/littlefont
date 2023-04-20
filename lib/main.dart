import 'package:flutter/material.dart';
import 'package:littlefont/Screens/AddCategoryPage/add_category_index.dart';
import 'Screens/FirstScreenPage/first_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
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
      home: const FirstScreen(),
    );
  }
}
