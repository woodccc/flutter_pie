import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()

class Movie {
  Movie(this.title);

  String title;
  // List subjects;
  // int count;
  // int start;
  // int total;
  
  factory Movie.fromJson(Map<Object, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}