import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:unit_testing_news_app/services/news_service.dart';

import '../models/article.dart';

class NewsController extends GetxController {
  final NewsService _newsService;

  NewsController(this._newsService);

  List<Article> _articles = [];

  List<Article> get articles => _articles;

  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  Future<void> getArticles() async {
    _isLoading.value = true;
    _articles = await _newsService.getArticles();
    _isLoading.value = false;
  }
}
