import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:flutter_pie/pages/home_page.dart';

import 'package:flutter_pie/pages/movie_detail_page.dart';

// One simple action: Increment
enum Actions { UpdateThemeColor }

// The reducer, which takes the previous count and increments it in response
// to an Increment action.
Map appReducer(dynamic state, dynamic action) {
  return state;
}

void main() {
  final store = new Store<dynamic>(appReducer, initialState: Colors.green);

  runApp(new FlutterReduxApp(
    title: 'Flutter Demo',
    store: store,
  ));
}

class FlutterReduxApp extends StatelessWidget {
  final Store<dynamic> store;
  final String title;

  FlutterReduxApp({Key key, this.store, this.title}) : super(key: key);
  // 定义路由信息
  final Map<String, Function> routes = {
    '/movie_detail_page': (context, {arguments}) =>
        MovieDetailPage(arguments: arguments)
  };

  @override
  Widget build(BuildContext context) {
    return StoreProvider<dynamic>(
      store: store,
      child: new StoreBuilder(
        builder: (context, store) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: store.state,
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
