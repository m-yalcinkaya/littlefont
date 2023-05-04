import 'recycle_bin_page_index.dart';

class RecycleBin extends ConsumerWidget {
  const RecycleBin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteRepo = ref.watch(notesProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Recycle Bin'),
      ),
      body: noteRepo.recycle.isEmpty
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'No deleted note',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 75,
                    right: 65,
                    left: 85,
                  ),
                  child: Text(
                    noteRepo.recyleInfo,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ))
          : Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20) +
                    const EdgeInsets.only(left: 15),
                child: Text(
                  noteRepo.recyleInfo,
                ),
              ),
              Expanded(child: buildGridView(ref: ref)),
            ]),
    );
  }

  GridView buildGridView({required WidgetRef ref}) {
    final noteRepo = ref.watch(notesProvider);
    final noteReadRepo = ref.read(notesProvider);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: noteRepo.recycle.length,
      itemBuilder: (context, index) {
        return Card(
          color: noteRepo.recycle[index].color,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowNote(index: index),
              ));
            },
            onLongPress: () {
              noteReadRepo.removeNoteFromRecycle(index);
            },
            child: Column(children: [
              const Spacer(),
              Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  noteRepo.recycle[index].title,
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
                      noteRepo.recycle[index].content,
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
