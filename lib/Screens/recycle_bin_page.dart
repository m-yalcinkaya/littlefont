import 'package:flutter/material.dart';
import 'package:littlefont/Repository/notes_repository.dart';
import 'package:littlefont/Screens/view_note_page.dart';

class RecycleBin extends StatefulWidget {
  final NotesRepository notesRepository;
  const RecycleBin({Key? key, required this.notesRepository}) : super(key: key);

  @override
  State<RecycleBin> createState() => _RecycleBinState();
}

class _RecycleBinState extends State<RecycleBin> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
            });
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Çöp Kutusu'),
      ),
      body: widget.notesRepository.recycle.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                    'Silinen Not Yok',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 40
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 75,right: 65,left: 85,),
                  child: Text(
                    widget.notesRepository.recyleInfo,
                    style: const TextStyle(
                         fontSize: 17),
                  ),
                ),
              ],
            ))
          : Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20) + const EdgeInsets.only(left: 15),
              child: Text(
                  widget.notesRepository.recyleInfo,
              ),
            ),
            Expanded(child: buildGridView()),

      ]
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
      itemCount: widget.notesRepository.recycle.length,
      itemBuilder: (context, index) {
        return Card(
          color: widget.notesRepository.recycle[index].color,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowNote(
                    index: index, notesRepository: widget.notesRepository),
              ));
            },
            onLongPress: () {
              widget.notesRepository.notes
                  .add(widget.notesRepository.recycle[index]);
              final interValue = widget.notesRepository.recycle[index];
              widget.notesRepository.recycle.remove(interValue);
              setState(() {});
            },
            child: Column(children: [
              const Spacer(),
              Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  widget.notesRepository.recycle[index].title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      widget.notesRepository.recycle[index].content,
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
