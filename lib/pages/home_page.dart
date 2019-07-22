import 'package:flutter/material.dart';
import 'package:github_demo/widget/my_tabbar_widget.dart';

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
        ),
      ));
    }

    return list;
  }

  _renderViews () {
    return [
      Text("aaa"),
      Text("bbb"),
      Text("ccc"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MYTabbarWidget(
        tabViews: _renderViews(),
        tabItems: _renderTabs(),
        topPageControl: topPageControl,
        backgroundColor: Colors.black45,
        indicatorColor: Colors.white,
        title: new Text("Github Demo"));
  }
}
