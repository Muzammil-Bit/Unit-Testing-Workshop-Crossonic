import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unit_testing_news_app/bloc/news_bloc.dart';
import 'package:unit_testing_news_app/ui/news_page.dart';

import 'services/news_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      home: BlocProvider(
        create: (_) => NewsBloc(NewsService()),
        child: const NewsPage(),
      ),
    );
  }
}
