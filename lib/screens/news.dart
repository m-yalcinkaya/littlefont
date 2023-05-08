import 'package:littlefont/items/app_drawer_index.dart';
import 'package:littlefont/items/bottom_nav_bar_index.dart';
import 'package:littlefont/repository/news_repository.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LittleFont News'),
        actions: [
          isLoading
              ? const CircularProgressIndicator()
              : IconButton(
                  onPressed: () async {
                    try {
                      setState(() {
                        isLoading = true;
                      });
                      await ref.read(newsProvider).showNews();
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  icon: const Icon(Icons.send))
        ],
      ),
      body: ListView.builder(
        itemCount: ref.watch(newsProvider).news.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                leading: Image.network(ref.watch(newsProvider).news[index].urlToImage),
                title: Text(ref.watch(newsProvider).news[index].title),
              ),
              const Divider(thickness: 1),
            ],
          );
        },
      ),
    );
  }
}
