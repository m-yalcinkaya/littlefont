import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../modals/news.dart';
import '../screens/view_news_page.dart';

class MyGridView extends ConsumerWidget {
  final List<News> list;
  const MyGridView({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      itemCount: list.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 12 / 10,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: ViewNewsPage(indexNews: index, list: list),
            );
          },
          child: Card(
            child: Stack(
              children: [
                Image.network(
                  list[index].urlToImage ??
                      'https://cdn.pixabay.com/photo/2014/06/16/23/39/black-370118_960_720.png',
                  fit: BoxFit.cover,
                  height: 171.4,
                  width: 205.7,
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
                                list[index]
                                    .title ??
                                    'Title : Null',
                                style: const TextStyle(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      )),
                ]),
              ],
            ),
          ),
        );
      },
    );
  }
}
