import 'package:flutter/material.dart';
import 'package:haberler/pages/news_page.dart';
import 'package:haberler/viewmodel/article_list_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Haberler',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.yellow,
            scaffoldBackgroundColor: Colors.yellow[200]),
        home: ChangeNotifierProvider(
          create: (context) => ArticleListViewModel(),
          child: const NewsPage(),
        ));
  }
}
