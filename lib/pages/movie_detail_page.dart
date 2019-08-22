import 'package:flutter/material.dart';

import 'package:flutter_pie/api/api.dart' as api;

import 'package:flutter_pie/api/model/movie_detail.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        alignment: Alignment.topCenter,
        constraints: BoxConstraints(minWidth: size.width),
        child: Stack(
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
                    MovieDetails(_movieDetail)
                  ],
                ),
              ),
            ),
            bottomFloatButton(context)
          ],
        ),
      ),
    );
  }

  Widget headerCover(imageUrl, heroTag, movieTitle, context) {
    final size = MediaQuery.of(context).size;
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
                  child: Image.network(imageUrl,
                      height: 500, width: 375, fit: BoxFit.fitWidth),
                ),
                tag: heroTag,
              ),
              Positioned(
                  left: 0,
                  bottom: 0,
                  width: 375,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.grey[850],
                            Colors.black
                          ],
                          stops: [
                            0,
                            0.7,
                            1
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    constraints: BoxConstraints(minWidth: size.width),
                    child: Container(
                      height: 60,
                      width: size.width,
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
    final size = MediaQuery.of(context).size;
    return Positioned(
      left: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pink[300], Colors.pink[400], Colors.pink[500]],
                stops: [0, 0.8, 1])),
        width: size.width,
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
    );
  }

  Widget MovieDetails(movie) {
    return Container(
      padding: EdgeInsets.only(bottom: 50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          color: Colors.white),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 380),
        child: Column(
          children: <Widget>[TextInfomation(movie)],
        ),
      ),
    );
  }

  Widget TextInfomation(movie) {
    if (movie.title.isEmpty)
      return Container(
        width: 375,
        alignment: Alignment.topCenter,
        child: Text("加载中"),
      );
    Widget _text(
        {text = "",
        color = Colors.black,
        size = 12.0,
        space = 0.0,
        weight = FontWeight.w400}) {
      return Text(
        text,
        style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: weight,
            letterSpacing: space),
      );
    }

    return Container(
      alignment: Alignment.topLeft,
      width: 375,
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _text(text: movie.title, size: 20.0, weight: FontWeight.w500),
          Padding(
            padding: EdgeInsets.only(top: 4, bottom: 6),
            child: _text(
                text: movie.original_title,
                color: Colors.grey[400],
                size: 11.0,
                weight: FontWeight.w300),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2, bottom: 2),
            child: _text(
                text:
                    '${movie.genres.join(" / ")} / ${movie.countries.join(" / ")} / ${movie.durations.join(" / ")}',
                color: Colors.grey[700],
                size: 11.0,
                weight: FontWeight.w300),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: _text(
                text: movie.pubdates.join(" / "),
                color: Colors.grey[700],
                size: 12.0,
                weight: FontWeight.w300),
          ),
          ratingSteps(),
          Divider(),
          Padding(
            padding: EdgeInsets.only(bottom: 3),
            child: _text(
                text: movie.summary,
                color: Colors.grey[700],
                size: 12.0,
                weight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  Widget ratingSteps() {
    return Row(
      children: <Widget>[
        Text(
          "豆瓣评分",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700]),
        ),
        RatingBar(
            initialRating: 3,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 25,
            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ))
      ],
    );
  }
}
