import 'package:flutter/material.dart';

import 'package:github_demo/api/api.dart' as api;

import 'package:github_demo/api/model/movie_detail.dart';

class MovieDetailPage extends StatefulWidget {
  MovieDetailPage({this.arguments});
  final Map arguments;

  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {

  var _movieDetail = new MovieDetail.fromJson({"title": ''});

  @override
  void initState() {
    super.initState();
    _loadMovieDetail();
  }

  _loadMovieDetail() async {
    var data = await api.getMovieDetail(widget.arguments["id"]);
    _movieDetail = data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _movieDetail.title.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                children: <Widget>[
                  Text(_movieDetail.title),
                  Image.network(
                    _movieDetail.images.small,
                    height: 200,
                  )
                ],
              ),
            ),
    );
  }
}
