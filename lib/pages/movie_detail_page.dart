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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            HeaderCover(
                widget.arguments["image"],
                'hero_tag_movie_image${widget.arguments["id"].toString()}',
                widget.arguments["title"]),
            Text(_movieDetail.title),
            PlaceholderBox()
          ],
        ),
      ),
    );
  }
}

Widget HeaderCover(imageUrl, heroTag, movieTitle) {
  return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: double.infinity,
          minHeight: 300,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Hero(
              child: Image.network(
                imageUrl,
                height: 300,
              ),
              tag: heroTag,
            ),
            Positioned(
                left: 0,
                bottom: 0,
                width: 375,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black],
                        stops: [0, 1],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                  child: Container(
                    height: 60,
                    child: Center(
                      child: Text(
                        movieTitle,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ));
}

Widget PlaceholderBox() {
  return Container(
    height: 4000,
    child: Center(
      child: Text("PlaceholderBox"),
    ),
  );
}
