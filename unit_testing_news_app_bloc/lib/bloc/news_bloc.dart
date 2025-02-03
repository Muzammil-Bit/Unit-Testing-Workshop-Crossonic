import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:unit_testing_news_app/models/article.dart';
import 'package:unit_testing_news_app/services/news_service.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsService _newsService;
  NewsBloc(this._newsService) : super(const NewsState()) {
    on<FetchArticles>(_onFetchArticles);
  }

  void _onFetchArticles(FetchArticles event, Emitter<NewsState> emit) async {
    emit(state.copyWith(status: NewsStatus.loading));
    try {
      final articles = await _newsService.getArticles();
      emit(state.copyWith(status: NewsStatus.success, articles: articles));
    } catch (e) {
      emit(state.copyWith(status: NewsStatus.failure));
    }
  }
}
