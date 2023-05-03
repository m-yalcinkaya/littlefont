import 'add_to_category_index.dart';

class AddToCategory extends ConsumerWidget {
  final int indexCategory;

  const AddToCategory({
    Key? key,
    required this.indexCategory,
  }) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Notlarım'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: buildGridView(ref: ref),
      ),
    );
  }

  GridView buildGridView({required ref}) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: ref.watch(notesProvider).notes.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowNote(
                  index: index,
                ),
              ));
            },
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                        final value = ref.read(notesProvider).notes[index];
                        ref.read(categoryProvider).noteOperation(indexCategory, value);
                    },
                    icon: ref.watch(categoryProvider).category[indexCategory].notes.contains(ref.watch(notesProvider).notes[index])
                        ? const Icon(Icons.add_box_rounded)
                        : const Icon(Icons.add_box_outlined),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  ref.watch(notesProvider).notes[index].title,
                  maxLines: 1,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
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
                      ref.watch(notesProvider).notes[index].content,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      ),
                  ),
                ),
              ),
              const Spacer(),
            ]),
          ),
        );
      },
    );
  }
}
