import 'package:flutter/material.dart';
import 'package:flutter_pie/widget/my_tabbar_widget.dart';

import 'package:flutter_pie/pages/page_one.dart';
import 'package:flutter_pie/pages/page_two.dart';
import 'package:flutter_pie/pages/page_three.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  final PageController topPageControl = new PageController();

  final List<String> tab = ["动态", "趋势", "我的"];

  _renderTabs() {
    List<Widget> list =  new List();
    for (int i = 0; i < tab.length; i ++) {
      list.add(FlatButton(
        onPressed: () {
         topPageControl.jumpTo(
           MediaQuery
            .of(context)
            .size
            .width * i
         );
        },
        child: Text(
          tab[i],
          maxLines: 1,
          style: TextStyle(color: Colors.white),
        ),
      ));
    }

    return list;
  }

  _renderViews () {
    return [
      PageOne(),
      PageTwo(),
      PageThree(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MYTabbarWidget(
        tabViews: _renderViews(),
        tabItems: _renderTabs(),
        topPageControl: topPageControl,
        backgroundColor: Colors.pink[300],
        indicatorColor: Colors.white,
        title: new Text("Flutter Pie"));
  }
}
