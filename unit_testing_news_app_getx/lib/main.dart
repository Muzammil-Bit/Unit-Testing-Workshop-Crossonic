import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:unit_testing_news_app/controllers/news_controller.dart';
import 'package:unit_testing_news_app/ui/news_page.dart';

import 'services/news_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(NewsController(NewsService()));

    return const MaterialApp(
      title: 'News App',
      home: NewsPage(),
    );
  }
}
