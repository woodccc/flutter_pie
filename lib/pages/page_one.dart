import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_pie/api/api.dart' as api;

import 'package:flutter_pie/pages/componnents/movie_item.dart';

class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final ScrollController _scrollController = new ScrollController();

  static const loadingTag = "##loading##";
  var _movieSubjects = <dynamic>[loadingTag];
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
    _movieSubjects = <dynamic>[loadingTag];
    _noMore = false;
    _total = 0;

    _loadData();  
  }

  _loadData() {
    if (_noMore) return;

    api.getMovieList(start: _movieSubjects.length, count: 13).then((data) {
      var _subjects = data.subjects.toList();

      _movieSubjects.insertAll(_movieSubjects.length - 1, _subjects);
      _total = data.total;

      if (_movieSubjects.length >= _total) {
        _noMore = true;
      }
      setState(() {});
    });
  }

  _buildItem(index) {
    final word = _movieSubjects[index];
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

    var movie = _movieSubjects[index];

    return MovieItem(movie: movie);
  }

  @override
  Widget build(BuildContext context) {
    Widget listView = ListView.separated(
      itemCount: _movieSubjects.length,
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
