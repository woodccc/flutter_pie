import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:flutter_pie/pages/home_page.dart';

import 'package:flutter_pie/pages/movie_detail_page.dart';
import 'package:flutter_pie/redux/index.dart';

void main() {
  runApp(new FlutterReduxApp());
}

class FlutterReduxApp extends StatelessWidget {
  final store = Store<APPState>(appReducer,
      initialState:
          new APPState(themeData: ThemeData(primarySwatch: Colors.pink)));

  FlutterReduxApp({Key key}) : super(key: key);
  // 定义路由信息
  final Map<String, Function> routes = {
    '/movie_detail_page': (context, {arguments}) =>
        MovieDetailPage(arguments: arguments)
  };

  @override
  Widget build(BuildContext context) {
    return StoreProvider<APPState>(
      store: store,
      child: new StoreBuilder<APPState>(
        builder: (context, store) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: store.state.themeData.primaryColor,
            ),
            home: HomePage(),
            onGenerateRoute: (RouteSettings settings) {
              // 统一处理
              final String name = settings.name;
              final Function pageContentBuilder = this.routes[name];
              if (pageContentBuilder != null) {
                final Route route = MaterialPageRoute(
                    builder: (context) => pageContentBuilder(context,
                        arguments: settings.arguments));
                return route;
              }
            },
          );
        },
      ),
    );
  }
}
