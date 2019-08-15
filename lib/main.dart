import 'package:flutter/material.dart';

import 'package:github_demo/pages/home_page.dart';

import 'package:github_demo/pages/movie_detail_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // 定义路由信息
  final Map<String, Function> routes = {
    '/movie_detail_page': (context, {arguments}) => MovieDetailPage(arguments: arguments)
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      onGenerateRoute: (RouteSettings settings) {
        // 统一处理
        final String name = settings.name;
        final Function pageContentBuilder = this.routes[name];
        if (pageContentBuilder != null) {
          final Route route = MaterialPageRoute(
              builder: (context) =>
                  pageContentBuilder(context, arguments: settings.arguments));
          return route;
        }
      },
    );
  }
}
