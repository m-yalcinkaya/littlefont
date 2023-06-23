import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/repository/news_repository.dart';
import 'package:littlefont_app/widgets/button.dart';
import 'package:littlefont_app/widgets/web_view.dart';

class ViewNewsPage extends ConsumerWidget {
  final int indexNews;
  const ViewNewsPage({Key? key, required this.indexNews}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                child: Image.network(ref.watch(newsProvider).newsList?[indexNews]
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
                      ref.watch(newsProvider).newsList?[indexNews].title ?? 'title = null',
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
                              'Author: ${ref.watch(newsProvider).newsList?[indexNews].author}')),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    ref.watch(newsProvider).newsList?[indexNews].content ?? 'content : null',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Button(
                    text: 'Click to read the whole',
                    color: Colors.red,
                    onPressedOperations: () {
                      ref.watch(newsProvider).newsList?[indexNews].url != null
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyWebView(
                                selectedUrl:
                                ref.watch(newsProvider).newsList![indexNews].url!,
                                title: ref.watch(newsProvider).newsList?[indexNews]
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
