// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movieList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieList _$MovieListFromJson(Map<String, dynamic> json) {
  return MovieList(
    json['count'] as int,
    json['start'] as int,
    json['total'] as int,
    json['subjects'] as List,
    json['title'] as String,
  );
}

Map<String, dynamic> _$MovieListToJson(MovieList instance) => <String, dynamic>{
      'title': instance.title,
      'subjects': instance.subjects,
      'count': instance.count,
      'start': instance.start,
      'total': instance.total,
    };
