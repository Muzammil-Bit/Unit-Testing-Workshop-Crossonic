import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unit_testing_news_app/models/article.dart';
import 'package:unit_testing_news_app/bloc/news_bloc.dart';
import 'package:unit_testing_news_app/services/news_service.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  late MockNewsService mockNewsService;

  setUp(() {
    mockNewsService = MockNewsService();
  });

  blocTest<NewsBloc, NewsState>("emits [] when nothing is added",
      build: () => NewsBloc(mockNewsService), expect: () => []);

  group('get articles', () {
    final articlesFromService = [
      Article(title: 'Test 1', content: 'Test 1 content'),
      Article(title: 'Test 2', content: 'Test 2 content'),
      Article(title: 'Test 3', content: 'Test 3 content'),
    ];

    void arrangeNewsServiceReturns3Articles() {
      when(mockNewsService.getArticles)
          .thenAnswer((_) async => articlesFromService);
    }

    blocTest<NewsBloc, NewsState>(
      """indicates loading of data,
      sets articles to the ones from the service,
      indicates that data is not being loaded anymore""",
      setUp: () => arrangeNewsServiceReturns3Articles(),
      build: () => NewsBloc(mockNewsService),
      act: (bloc) => bloc.add(FetchArticles()),
      expect: () => [
        const NewsState(articles: [], status: NewsStatus.loading),
        NewsState(articles: articlesFromService, status: NewsStatus.success),
      ],
    );

    blocTest<NewsBloc, NewsState>(
      """handles errors gracefully when fetching articles fails""",
      setUp: () => when(mockNewsService.getArticles).thenThrow(Exception()),
      build: () => NewsBloc(mockNewsService),
      act: (bloc) => bloc.add(FetchArticles()),
      expect: () => [
        const NewsState(articles: [], status: NewsStatus.loading),
        const NewsState(articles: [], status: NewsStatus.failure),
      ],
    );
  });
}
