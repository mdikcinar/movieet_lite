// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trend _$TrendFromJson(Map<String, dynamic> json) => Trend(
      adult: json['adult'] as bool?,
      gender: json['backdrop_path'] as int?,
      backdropPath: json['backdropPath'] as String?,
      genreIds:
          (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      id: json['id'] as int?,
      knownForDepartment: json['known_for_department'] as String?,
      title: json['title'] as String?,
      mediaType: json['media_type'] as String?,
      name: json['name'] as String?,
      originCountry: (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      originalName: json['original_name'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] as String?,
      profilePath: json['profile_path'] as String?,
      releaseDate: json['release_date'] as String?,
      firstAirDate: json['first_air_date'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
      knownFor: (json['known_for'] as List<dynamic>?)
          ?.map((e) => Trend.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrendToJson(Trend instance) => <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.gender,
      'backdropPath': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'known_for_department': instance.knownForDepartment,
      'title': instance.title,
      'media_type': instance.mediaType,
      'name': instance.name,
      'origin_country': instance.originCountry,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'profile_path': instance.profilePath,
      'release_date': instance.releaseDate,
      'first_air_date': instance.firstAirDate,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'known_for': instance.knownFor,
    };
