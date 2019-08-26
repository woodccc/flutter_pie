import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_pie/api/api.dart' as api;

import 'package:flutter_pie/api/model/movie_detail.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        alignment: Alignment.topLeft,
        constraints: BoxConstraints(minWidth: ScreenUtil.getInstance().setWidth(750)),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(color: Colors.black),
                width: ScreenUtil.getInstance().setWidth(750),
                child: Column(
                  children: <Widget>[
                    headerCover(
                        widget.arguments["image"],
                        'hero_tag_movie_image${widget.arguments["id"].toString()}',
                        widget.arguments["title"],
                        context),
                    MovieDetails(_movieDetail, context)
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
    return Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: ScreenUtil.getInstance().setWidth(750),
            minHeight: 300,
          ),
          child: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              Hero(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.network(imageUrl,
                      height: 500, width: ScreenUtil.getInstance().setWidth(750), fit: BoxFit.fitWidth),
                ),
                tag: heroTag,
              ),
              Positioned(
                  left: 0,
                  bottom: 0,
                  width: ScreenUtil.getInstance().setWidth(750),
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
                    constraints: BoxConstraints(minWidth: ScreenUtil.getInstance().setWidth(750)),
                    child: Container(
                      height: 60,
                      width: ScreenUtil.getInstance().setWidth(750),
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
      left: 0,
      bottom: 0,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.pink[300],
            Colors.pink[400],
            Colors.pink[500]
          ], stops: [
            0,
            0.8,
            1
          ])),
          width: ScreenUtil.getInstance().setWidth(750),
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

  Widget MovieDetails(movie, context) {
    return Container(
      padding: EdgeInsets.only(bottom: 50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          color: Colors.white),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 380),
        child: Column(
          children: <Widget>[TextInfomation(movie, context)],
        ),
      ),
    );
  }

  Widget TextInfomation(movie, context) {
    if (movie.title.isEmpty)
      return Container(
        width: ScreenUtil.getInstance().setWidth(750),
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 20),
        child: SpinKitThreeBounce(
          color: Colors.blue,
          size: 20.0,
        ),
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
      width: ScreenUtil.getInstance().setWidth(750),
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
