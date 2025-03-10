import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unit_testing_news_app/providers/news_change_notifier.dart';
import 'package:unit_testing_news_app/ui/news_page.dart';

import 'service/news_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(NewsService()),
        child: const NewsPage(),
      ),
    );
  }
}
