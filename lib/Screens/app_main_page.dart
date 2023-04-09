import 'package:flutter/material.dart';


class MyHomePage extends StatelessWidget {
  final notlar = ['Mustafa', 'meryem'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          MySliverAppBar(),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Card(
                      elevation: 20,
                      child: Text('Musafa00'),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Card(
                      elevation: 20,
                      child: Text('Musafa00'),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Card(
                      elevation: 20,
                      child: Text('Musafa00'),
                    ),
                  ),

                ],
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



