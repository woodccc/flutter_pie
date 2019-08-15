import 'package:flutter/material.dart';

import 'package:flutter_pie/api/api.dart' as api;

import 'package:flutter_pie/api/model/movie_detail.dart';

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
      body: Column(
        children: <Widget>[
          Hero(
            child: Image.network(
              widget.arguments["image"],
              height: 300,
            ),
            tag: 'hero_tag_movie_image${widget.arguments["id"].toString()}',
          ),
          Text(_movieDetail.title),
        ],
      ),
    );
  }
}
