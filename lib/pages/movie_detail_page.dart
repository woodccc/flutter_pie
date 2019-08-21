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
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SingleChildScrollView(
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.black),
              child: Column(
                children: <Widget>[
                  headerCover(
                      widget.arguments["image"],
                      'hero_tag_movie_image${widget.arguments["id"].toString()}',
                      widget.arguments["title"],
                      context),
                  placeholderBox()
                ],
              ),
            ),
          ),
          bottomFloatButton(context),
        ],
      ),
    );
  }
}

Widget headerCover(imageUrl, heroTag, movieTitle, context) {
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
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Image.network(
                  imageUrl,
                  height: 300,
                ),
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

Widget bottomFloatButton(context) {
  return Positioned(
    left: -16,
    bottom: 0,
    child: FlatButton(
      onPressed: () => Navigator.pop(context),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pink[300], Colors.pink[400], Colors.pink[500]], stops: [0, 0.8, 1])),
        width: 375,
        height: 50,
        alignment: Alignment.center,
        child: Text(
          "特惠抢票",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              letterSpacing: 2,
              fontSize: 18),
        ),
      ),
    ),
  );
}

Widget placeholderBox() {
  return Container(
    height: 800,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        color: Colors.white),
    child: Center(
      child: Text("placeholderBox"),
    ),
  );
}
