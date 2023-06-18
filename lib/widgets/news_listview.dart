import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../modals/news.dart';
import '../screens/view_news_page.dart';


class NewsListView extends StatelessWidget {
  final List<News>? data;
  const NewsListView({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: data!.length,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: 265,
          child: InkWell(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: ViewNewsPage(indexNews: index, list: data!),
              );
            },
            child: Card(
              child: Stack(
                children: [
                  Image.network(
                    data![index].urlToImage ??
                        'https://cdn.pixabay.com/photo/2014/06/16/23/39/black-370118_960_720.png',
                    fit: BoxFit.cover,
                    height: 142,
                    width: 257,
                  ),
                  Column(children: [
                    const Expanded(flex: 4, child: SizedBox()),
                    Expanded(
                        flex: 3,
                        child: Container(
                          color: Colors.black38,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: AutoSizeText(
                                data![index].title ?? 'title: null',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )),
                  ]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}