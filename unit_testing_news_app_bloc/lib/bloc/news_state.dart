part of 'news_bloc.dart';

enum NewsStatus { loading, success, failure }

@immutable
class NewsState extends Equatable {
  final NewsStatus status;
  final List<Article> articles;
  const NewsState({
    this.status = NewsStatus.success,
    this.articles = const <Article>[],
  });

  NewsState copyWith({
    NewsStatus? status,
    List<Article>? articles,
  }) {
    return NewsState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
    );
  }

  @override
  List<Object> get props => [status, articles];
}
