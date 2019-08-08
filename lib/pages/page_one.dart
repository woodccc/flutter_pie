import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:github_demo/api/api.dart' as api;

import 'package:github_demo/api/model/movie.dart';

class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final ScrollController _scrollController = new ScrollController();

  static const loadingTag = "##loading##";
  var _words = <dynamic>[loadingTag];
  var _noMore = false;
  var _total = 0;

  @override
  void initState() {
    super.initState();

    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        this._loadData();
      }
    });
  }

  Future<Null> _refreshData() async {
    _words = <dynamic>[loadingTag];
    _noMore = false;
    _total = 0;

    _loadData();  
  }

  _loadData() {
    if (_noMore) return;

    api.getMovieList(start: _words.length, count: 13).then((data) {
      var _subjects = data.subjects.toList();

      _words.insertAll(_words.length - 1, _subjects);
      _total = data.total;

      if (_words.length >= _total) {
        _noMore = true;
      }
      setState(() {});
    });
  }

  _buildItem(index) {
    final word = _words[index];
    if (word == loadingTag) {
      if (_noMore) {
        return Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text("……滑到底了……"),
        );
      } else {
        return Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: SpinKitThreeBounce(
            color: Colors.blue,
            size: 20.0,
          ),
        );
      }
    }

    var movie = Movie.fromJson(_words[index]);

    return ListTile(
        title: Text(movie.title),
        trailing: Icon(IconData(0xe600, fontFamily: "iconfont"), size: 16.0));
  }

  @override
  Widget build(BuildContext context) {
    Widget listView = ListView.separated(
      itemCount: _words.length,
      itemBuilder: (context, index) {
        return _buildItem(index);
      },
      separatorBuilder: (index, context) => Divider(height: .0),
      controller: _scrollController,
    );

    return new RefreshIndicator( // 下拉刷新
      child: listView,
      onRefresh: _refreshData,
    );
  }
}
