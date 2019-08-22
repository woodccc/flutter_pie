import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  MovieItem({this.movie});

  final movie;

  Widget MovieCard() {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(left: 16),
      height: 216,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2))),
      child: Row(
        children: <Widget>[
          MovieImage(movie.images.small, 'hero_tag_movie_image${movie.id.toString()}'),
          MovieInformation(movie),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MovieCard(),
      onTap: () {
        Navigator.pushNamed(context, "/movie_detail_page",
            arguments: {"id": movie.id, "image": movie.images.large, "title": movie.title });
      },
    );
  }
}

Widget MovieImage (url, hero_tag) {
  return Hero(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        url,
        height: 180,
      ),
    ),
    tag: hero_tag,
  );
}

Widget MovieInformation (movie) {
  return Expanded(
    child: Padding(
      padding: EdgeInsets.only(top: 8, left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Text(
              movie.title,
              style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500,),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: true
            ),
          ),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: '豆瓣评分 ',
              style: TextStyle(color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: '${movie.rating.average}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow[800]))
              ],
            ),
            
          ),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: '导演: ',
              style: TextStyle(color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: '${movie.directors.map((e) => e.name).join(" ")}', style: TextStyle(fontWeight: FontWeight.w500))
              ],
            ),
            
          ),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: '主演: ',
              style: TextStyle(color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: '${movie.casts.map((e) => e.name).join(" ")}', style: TextStyle(fontWeight: FontWeight.w500),)
              ],
            ),
            
          ),
          Text('${movie.genres.join(" , ")}', style: TextStyle(fontSize: 14, color: Colors.black54)),
          Text('${movie.pubdates[0]}', style: TextStyle(fontSize: 14, color: Colors.black54)),
      ],),
    ),
  );
}
