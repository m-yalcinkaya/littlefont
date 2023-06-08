import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/category_repository.dart';
import 'package:littlefont_app/screens/add_to_category.dart';
import 'package:littlefont_app/screens/view_note_page.dart';

class ShowCategory extends ConsumerWidget {
  final int indexCategory;

  const ShowCategory({
    Key? key,
    required this.indexCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            ref.watch(categoryProvider).category[indexCategory].categoryName),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddToCategory(indexCategory: indexCategory),
                  ));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: buildGridView(ref: ref),
      ),
    );
  }

  GridView buildGridView({required WidgetRef ref}) {
    final categoryRepo = ref.read(categoryProvider);
    final categoryWatchRepo = ref.watch(categoryProvider);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: categoryWatchRepo.category[indexCategory].notes.length,
      itemBuilder: (context, index) {
        return Card(
          color: const Color.fromARGB(200, 220, 200, 210),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowCategoryNote(
                  index: index,
                  indexCategory: indexCategory,
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
                            'Are you sure you want to remove this note from the category '),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);

                              final note = categoryRepo
                                  .category[indexCategory].notes[index];
                              categoryRepo.removeNoteFromCategory(
                                  indexCategory, note);
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
              Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  categoryWatchRepo.category[indexCategory].notes[index].title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      categoryWatchRepo
                          .category[indexCategory].notes[index].content,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () async {
                      await FlutterShare.share(
                        title: 'Share your note',
                        text:
                            '${categoryRepo.category[indexCategory].notes[index].title}\n\n${categoryRepo.category[indexCategory].notes[index].content}',
                      );
                    },
                    icon: const Icon(Icons.share),
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
