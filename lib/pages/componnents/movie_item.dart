import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  MovieItem({this.movie});

  final movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(8),
        height: 300,
        child: Column(
          children: <Widget>[
            Image.network(
              movie.images.small,
              height: 180,
            ),
            Text(movie.title),
            Text(movie.genres[0]),
            Text(movie.rating.average.toString()),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, "/movie_detail_page",
            arguments: {"id": movie.id});
      },
    );
  }
}
