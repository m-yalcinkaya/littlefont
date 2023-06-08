import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/category_repository.dart';
import 'package:littlefont_app/repository/notes_repository.dart';

class ShowNote extends ConsumerWidget {
  final int index;

  const ShowNote({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 300,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ref.watch(notesProvider).notes[index].title,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                child: Text(ref.watch(notesProvider).notes[index].content),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowCategoryNote extends ConsumerWidget {
  final int index;
  final int indexCategory;

  const ShowCategoryNote({
    Key? key,
    required this.index,
    required this.indexCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 300,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ref
                        .watch(categoryProvider)
                        .category[indexCategory]
                        .notes[index]
                        .title,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                child: Text(
                  ref
                      .watch(categoryProvider)
                      .category[indexCategory]
                      .notes[index]
                      .title,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
