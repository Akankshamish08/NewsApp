import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/categories_news_model.dart';
import 'package:newsapp/models/news_channel_headlines_model.dart';

class NewsRepository{
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi() async{
    String url = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=158f7e14f2ae4bff80159bfa92e559a3";
    final response = await http.get(Uri.parse(url));
    if(kDebugMode){
      print(response.body);
    }
    if(response.statusCode == 200){
      final body = jsonDecode(response.body);

      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }
  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async{
    String url = "https://newsapi.org/v2/everything?q=${category}&apiKey=158f7e14f2ae4bff80159bfa92e559a3";
    final response = await http.get(Uri.parse(url));
    if(kDebugMode){
      print(response.body);
    }
    if(response.statusCode == 200){
      final body = jsonDecode(response.body);

      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Error');
  }
  Future<Map<String, dynamic>> getNewsByQuery(String query) async {
    final response = await http.get(
      Uri.parse("https://newsapi.org/v2/everything?q=$query&apiKey=YOUR_API_KEY"),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to Search");
    }
  }

}
