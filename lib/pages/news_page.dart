import 'package:flutter/material.dart';
import 'package:haberler/models/category.dart';
import 'package:haberler/viewmodel/article_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Category> categories = [
    Category('business', 'İŞ'),
    Category('entertainment', 'EĞLENCE'),
    Category('general', 'GENEL'),
    Category('health', 'SAĞLIK'),
    Category('science', 'BİLİM'),
    Category('technology', 'TEKNOLOJİ'),
    Category('sports', 'SPOR'),
  ];
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ArticleListViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.newspaper),
          title: const Text('Haberler',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: getCategoriesTab(vm),
              ),
            ),
            getWidgetByStatus(vm)
          ],
        ));
  }

  List<GestureDetector> getCategoriesTab(ArticleListViewModel vm) {
    List<GestureDetector> list = [];
    for (int i = 0; i < categories.length; i++) {
      list.add(GestureDetector(
        onTap: () => vm.getNews(categories[i].key),
        child: Card(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  categories[i].title,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )),
      ));
    }
    return list;
  }

  Widget getWidgetByStatus(ArticleListViewModel vm) {
    switch (vm.status.index) {
      case 2:
        return Expanded(
            child: ListView.builder(
          itemCount: vm.viewModel.articles.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Image.network(vm.viewModel.articles[index].urlToImage ??
                      'https://www.invenura.com/wp-content/themes/consultix/images/no-image-found-360x250.png'),
                  ListTile(
                    title: Text(
                      vm.viewModel.articles[index].title ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(vm.viewModel.articles[index].author ?? ''),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(vm.viewModel.articles[index].description ?? ''),
                  ),
                  ButtonBar(
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          await launchUrl(Uri.parse(
                              vm.viewModel.articles[index].url ?? ''));
                        },
                        child: Row(children: const [
                          Icon(
                            Icons.arrow_circle_right_outlined,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Habere Git',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ]),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ));
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
