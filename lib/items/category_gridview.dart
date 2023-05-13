import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/category_repository.dart';
import '../screens/show_category_notes.dart';

class CategoryGridview extends ConsumerWidget {
  const CategoryGridview({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 3 / 2,
      ),
      itemCount: ref.watch(categoryProvider).category.length,
      itemBuilder: (context, index) {
        return Card(
          color: const Color.fromARGB(150, 120, 220, 220),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowCategory(
                  indexCategory: index,
                ),
              ));
            },
            child: Column(children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Alert'),
                        content: const Text(
                            'Are you sure you want to delete this category?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ref.read(categoryProvider).removeCategory(index);
                            },
                            child: const Text('Delete'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                    ref.watch(categoryProvider).category[index].categoryName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  )),
            ]),
          ),
        );
      },
    );
  }
}