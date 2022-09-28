import 'dart:convert';
import 'package:haberler/models/articles.dart';
import 'package:http/http.dart' as http;
import '../models/news.dart';

class NewsService {
  Future<List<Article>> fetchNews(String category) async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=tr&category=$category&apiKey=17b389010bbf4a5b999f2e41c39560f9';
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      News news = News.fromJson(result);
      return news.articles ?? [];
    }
    throw Exception('Bad Request');
  }
}
