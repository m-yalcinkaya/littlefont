import 'show_category_notes_page_index.dart';

class ShowCategory extends StatefulWidget {
  final int indexCategory;
  final NotesRepository notesRepository;

  const ShowCategory({
    Key? key,
    required this.indexCategory,
    required this.notesRepository,
  }) : super(key: key);

  @override
  State<ShowCategory> createState() => _ShowCategoryState();
}

class _ShowCategoryState extends State<ShowCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.notesRepository.category[widget.indexCategory].categoryName),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            color: Colors.white,
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddToCategory(
                        notesRepository: widget.notesRepository,
                        indexCategory: widget.indexCategory),
                  ));
              setState(() {});
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: buildGridView(),
      ),
    );
  }

  GridView buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount:
          widget.notesRepository.category[widget.indexCategory].notes.length,
      itemBuilder: (context, index) {
        return Card(
          color: const Color.fromARGB(200, 220, 200, 210),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowCategoryNote(
                  index: index,
                  notesRepository: widget.notesRepository,
                  indexCategory: widget.indexCategory,
                ),
              ));
            },
            child: Column(children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Uyarı'),
                        content: const Text(
                            'Bu kategoriyi silmek istediğinize emin misiniz?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              widget.notesRepository
                                  .category[widget.indexCategory].notes
                                  .remove(widget
                                      .notesRepository
                                      .category[widget.indexCategory]
                                      .notes[index]);
                            },
                            child: const Text('Sil'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('İptal'),
                          ),
                        ],
                      ),
                    );
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  widget.notesRepository.category[widget.indexCategory]
                      .notes[index].title,
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
                      widget.notesRepository.category[widget.indexCategory]
                          .notes[index].content,
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
                        title: 'Notunu Paylaş',
                        text:
                            '${widget.notesRepository.category[widget.indexCategory].notes[index].title}\n\n${widget.notesRepository.category[widget.indexCategory].notes[index].content}',
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
