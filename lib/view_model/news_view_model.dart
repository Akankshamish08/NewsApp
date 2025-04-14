import 'package:newsapp/models/categories_news_model.dart';
import 'package:newsapp/models/news_channel_headlines_model.dart';
import 'package:newsapp/repository/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi() async {
    final response = await _repo.fetchNewsChannelHeadlinesApi();
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    final response = await _repo.fetchCategoriesNewsApi(category);
    return response;
  }

  Future<NewsChannelsHeadlinesModel?> fetchNewsByQuery(String query) async {
    final response = await _repo.getNewsByQuery(query);
    return NewsChannelsHeadlinesModel.fromJson(response);
  }
}
