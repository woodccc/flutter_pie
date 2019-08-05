import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:github_demo/api/api.dart' as api;

class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final ScrollController _scrollController = new ScrollController();

  static const loadingTag = "##loading##";
  var _words = <String>[loadingTag];
  var _noMore = false;

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
    api.getMovieList()
      .then((data) {
        print('------------------------');
        print(data.title);
      });
  }

  _loadData() {
    if (_noMore) return;

    Future.delayed(Duration(seconds: 2)).then((e) {
      var _newWords = [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10"
      ].toList();
      _words.insertAll(_words.length - 1, _newWords);
      if (_words.length > 100) {
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

    return ListTile(
      title: Text(_words[index]),
      trailing: Icon(IconData(0xe600, fontFamily: "iconfont"), size: 16.0)
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _words.length,
      itemBuilder: (context, index) {
        return _buildItem(index);
      },
      separatorBuilder: (index, context) => Divider(height: .0),
      controller: _scrollController,
    );
  }
}
