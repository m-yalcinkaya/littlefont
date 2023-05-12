import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:littlefont/items/button.dart';
import 'package:littlefont/modals/news.dart';
import 'package:littlefont/items/web_view.dart';

class ViewNewsPage extends StatelessWidget {
  final int indexNews;
  final List<News> list;
  const ViewNewsPage({Key? key, required this.indexNews, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              expandedTitleScale: 1.5,
              background: FittedBox(
                fit: BoxFit.fill,
                child: Image.network(list[indexNews]
                        .urlToImage ??
                    'https://cdn.pixabay.com/photo/2014/06/16/23/39/black-370118_960_720.png'),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: AutoSizeText(
                      minFontSize: 22,
                      list[indexNews].title ?? 'title = null',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: Text(
                              'Author: ${list[indexNews].author}')),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    list[indexNews].content ?? 'content : null',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Button(
                    text: 'Click to read the whole',
                    color: Colors.red,
                    onPressedOperations: () {
                      list[indexNews].url != null
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyWebView(
                                selectedUrl:
                                    list[indexNews].url!,
                                title: list[indexNews]
                                    .title ?? 'title : null',
                              ),
                            ))
                          : null;
                    },
                    width: 100,
                    height: 50,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
