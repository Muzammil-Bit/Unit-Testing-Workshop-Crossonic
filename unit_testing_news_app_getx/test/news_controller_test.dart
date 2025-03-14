import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unit_testing_news_app/models/article.dart';
import 'package:unit_testing_news_app/controllers/news_controller.dart';
import 'package:unit_testing_news_app/services/news_service.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  late NewsController sut;
  late MockNewsService mockNewsService;

  setUp(() {
    mockNewsService = MockNewsService();
    sut = NewsController(mockNewsService);
  });

  test(
    "initial values are correct",
    () {
      expect(sut.articles, []);
      expect(sut.isLoading, false);
    },
  );

  group('group articles', () {
    final articlesFromService = [
      Article(title: 'Test 1', content: 'Test 1 content'),
      Article(title: 'Test 2', content: 'Test 2 content'),
      Article(title: 'Test 3', content: 'Test 3 content'),
    ];

    void arrangeNewsServiceReturns3Articles() {
      when(mockNewsService.getArticles)
          .thenAnswer((_) async => articlesFromService);
    }

    test(
      "gets articles using the NewsService",
      () async {
        arrangeNewsServiceReturns3Articles();
        await sut.getArticles();
        verify(() => mockNewsService.getArticles()).called(1);
      },
    );

    test(
      """indicates loading of data,
      sets articles to the ones from the service,
      indicates that data is not being loaded anymore""",
      () async {
        arrangeNewsServiceReturns3Articles();
        final future = sut.getArticles();
        expect(sut.isLoading, true);
        await future;
        expect(sut.articles, articlesFromService);
        expect(sut.isLoading, false);
      },
    );
  });
}
