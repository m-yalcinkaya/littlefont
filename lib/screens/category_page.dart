import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/screens/app_main_page.dart';
import '../widgets/category_gridview.dart';
import 'package:littlefont_app/screens/add_category.dart';

class CategoryPage extends ConsumerWidget {
  const CategoryPage({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const AppMainPage(),)
            );
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text('Categories'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const AddCategory(),
              ));
            },
            icon: const Icon(Icons.add_circle, color: Colors.white),
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: CategoryGridview(),
      ),
    );
  }
}
