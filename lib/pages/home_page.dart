import 'package:flutter/material.dart';
import 'package:github_demo/widget/my_tabbar_widget.dart';

import 'package:github_demo/pages/page_one.dart';
import 'package:github_demo/pages/page_two.dart';
import 'package:github_demo/pages/page_three.dart';

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
        backgroundColor: Colors.blue[400],
        indicatorColor: Colors.white,
        title: new Text("Github Demo"));
  }
}
