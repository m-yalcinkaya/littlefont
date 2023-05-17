import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/category_repository.dart';
import '../screens/show_category_notes.dart';

class CategorySliverGrid extends ConsumerWidget {
  const CategorySliverGrid({
    super.key,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverGrid(
      gridDelegate:
      const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 2,
      ),
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ShowCategory(indexCategory: index),
                    ));
              },
              child: Center(
                  child: Text(
                    ref.watch(categoryProvider).category[index].categoryName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ),
          );
        },
        childCount: ref.watch(categoryProvider).category.length,
      ),
    );
  }
}
