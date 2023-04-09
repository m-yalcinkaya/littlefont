import 'package:flutter/material.dart';
import 'package:littlefont/Repository/notes_repository.dart';



class MyHomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    NotesRepository notesRepository = NotesRepository();

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          MySliverAppBar(),
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 150, // Notlar için ayrılan alanın yüksekliği
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Notları yatay olarak göster
                itemCount: notesRepository.notlar.length, // Kaç tane notunuz varsa burada belirtin
                itemBuilder: (BuildContext context, int index) {
                  return PhysicalModel(
                    borderRadius: BorderRadius.circular(25),
                    elevation: 20,
                    color: Colors.white70,
                    child: Container(
                      width: 200, // Her not için ayrılan alanın genişliği
                      child: Card(
                        child: ListTile(
                          title: Text(notesRepository.notlar[index].title),
                          subtitle: Text(notesRepository.notlar[index].content),
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
        title: Text('Merhaba, Mustafa'),
        background: FittedBox(
          fit: BoxFit.cover,
            child: Image(image: AssetImage(
                'assets/images/pexels-photo-1039083.jpg'),
            ),
        ),
      ),
    );
  }
}



