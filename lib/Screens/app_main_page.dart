import 'package:flutter/material.dart';
import 'package:littlefont/Items/app_drawer.dart';
import 'package:littlefont/Repository/notes_repository.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late NotesRepository notesRepository;

  @override
  void initState() {
    notesRepository = NotesRepository();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const MySliverAppBar(),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: notesRepository.notes.length,
                itemBuilder: (BuildContext context, int index) {
                  return PhysicalModel(
                    borderRadius: BorderRadius.circular(25),
                    elevation: 20,
                    color: Colors.white70,
                    child: SizedBox(
                      width: 200,
                      child: Card(
                        child: ListTile(
                          title: Text(notesRepository.notes[index].title),
                          subtitle: Text(notesRepository.notes[index].content),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(notesRepository: notesRepository,),
    );
  }
}


class MySliverAppBar extends StatelessWidget {
  const MySliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        expandedTitleScale: 1.5,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SizedBox(width: 10), // veya Expanded(child: SizedBox()),
            Text('Başlık'),
          ],
        ),
        background: const FittedBox(
          fit: BoxFit.cover,
            child: Image(image: AssetImage(
                'assets/images/pexels-photo-1039083.jpg'),
            ),
        ),
      ),
    );
  }
}



