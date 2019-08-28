import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:flutter_pie/pages/home_page.dart';

import 'package:flutter_pie/pages/movie_detail_page.dart';
import 'package:flutter_pie/redux/index.dart';

void main() {
  final store = Store<ThemeColorState>(reducer,
      initialState: ThemeColorState.initState());

  runApp(new FlutterReduxApp(
    title: 'Flutter Demo',
    store: store,
  ));
}

class FlutterReduxApp extends StatelessWidget {
  final Store<ThemeColorState> store;
  final String title;

  FlutterReduxApp({Key key, this.store, this.title}) : super(key: key);
  // 定义路由信息
  final Map<String, Function> routes = {
    '/movie_detail_page': (context, {arguments}) =>
        MovieDetailPage(arguments: arguments)
  };

  @override
  Widget build(BuildContext context) {
    return StoreProvider<ThemeColorState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
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
      ),
    );
  }
}
