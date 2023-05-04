import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:littlefont/screens/category_page.dart';
import '../repository/category_repository.dart';

class AddCategory extends ConsumerStatefulWidget {
  const AddCategory({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends ConsumerState<AddCategory> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool? _isFounded(CategoryRepository categoryRepo, String? value) {
    for (int i = 0; i < categoryRepo.category.length;) {
      if (categoryRepo.category[i].categoryName == value) {
        return true;
      }
      return false;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final categoryRepo = ref.read(categoryProvider);

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Category'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(50),
              child: TextFormField(
                maxLength: 50,
                controller: _controller,
                validator: (value) {
                  return _isFounded(categoryRepo, value)!
                      ? 'A category name with the same name already exists!!'
                      : null;
                },
                style: const TextStyle(
                  fontSize: 20,
                ),
                decoration:
                    const InputDecoration(hintText: 'Create a new category'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final isSuitable = _formKey.currentState?.validate();
                if (isSuitable == true) {
                  categoryRepo.addCategory(_controller.text);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryPage(),
                      ));
                }
              },
              child: const Text('Create'),
            )
          ],
        ),
      ),
    );
  }
}
