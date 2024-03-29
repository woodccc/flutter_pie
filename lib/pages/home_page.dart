// dependency
import 'package:flutter/material.dart';
import 'package:flutter_pie/redux/theme_data_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_redux/flutter_redux.dart';
// widget
import 'package:flutter_pie/widget/my_tabbar_widget.dart';
// pages
import 'package:flutter_pie/pages/page_one.dart';
import 'package:flutter_pie/pages/page_two.dart';
import 'package:flutter_pie/pages/page_three.dart';
// redux
import 'package:flutter_pie/redux/index.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final PageController topPageControl = new PageController();

  final List<String> tab = ["动态", "趋势", "我的"];

  _renderTabs() {
    List<Widget> list = new List();
    for (int i = 0; i < tab.length; i++) {
      list.add(FlatButton(
        onPressed: () {
          topPageControl.jumpTo(MediaQuery.of(context).size.width * i);
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

  _renderViews() {
    return [
      PageOne(),
      PageTwo(),
      PageThree(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // 初始设置 ScreenUtil 屏幕宽高
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return new StoreConnector<APPState, dynamic>(
      converter: (store) => store.state.themeData.primaryColor,
      builder: (context, themeColor) {
        return MYTabbarWidget(
            tabViews: _renderViews(),
            tabItems: _renderTabs(),
            topPageControl: topPageControl,
            backgroundColor: themeColor,
            indicatorColor: Colors.white,
            drawer: homeDrawer(),
            title: new Text("Flutter Pie"));
      },
    );
  }

  Widget homeDrawer() {
    final List colors = [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
    ];
    colors_list(onClick) {
      return colors.map((item) {
        return GestureDetector(
          onTap: () {
            onClick(item);
          },
          child: Container(
            child: Text(""),
            // color: item,
            height: ScreenUtil.getInstance().setHeight(60),
            padding: EdgeInsets.all(4.0),
            margin:
                EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(12)),
            decoration: BoxDecoration(
                color: item,
                border: Border.all(
                    width: ScreenUtil.getInstance().setWidth(2),
                    color: Colors.white)),
          ),
        );
      }).toList();
    }

    return new StoreConnector<APPState, ThemeColorViewModel>(
        converter: (store) {
      return ThemeColorViewModel(
        color: store.state.themeData.primaryColor,
        onClick: (item) => store.dispatch(
            new RefreshThemeDataAction(ThemeData(primarySwatch: item))),
      );
    }, builder: (context, vm) {
      return Container(
        alignment: Alignment.topCenter,
        child: ListView(
          children: colors_list(vm.onClick),
        ),
        width: ScreenUtil.getInstance().setWidth(500),
        height: ScreenUtil.getInstance().setHeight(1334),
        padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(16)),
        decoration: BoxDecoration(color: vm.color),
      );
    });
  }
}

class ThemeColorViewModel {
  final dynamic color;
  final void Function(Color color) onClick;

  ThemeColorViewModel({this.color, this.onClick});
}
