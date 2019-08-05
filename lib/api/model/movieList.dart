import 'package:json_annotation/json_annotation.dart';

part 'movieList.g.dart';

@JsonSerializable()

class MovieList {
  MovieList(this.count, this.start, this.total, this.subjects, this.title);

  String title;
  List subjects;
  int count;
  int start;
  int total;
  
  factory MovieList.fromJson(Map<Object, dynamic> json) => _$MovieListFromJson(json);
  Map<String, dynamic> toJson() => _$MovieListToJson(this);
}