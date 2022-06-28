import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../0-core/base/model/base_model.dart';

part 'trend_movie.g.dart';

@JsonSerializable()
class TrendMovie extends Equatable with BaseModel {
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  final double? popularity;

  const TrendMovie(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.popularity});

  factory TrendMovie.fromJson(Map<String, dynamic> json) => _$TrendMovieFromJson(json);

  @override
  TrendMovie fromJson(Map<String, dynamic> json) {
    return _$TrendMovieFromJson(json);
  }

  @override
  Map<String, Object?> toJson() {
    return _$TrendMovieToJson(this);
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalLanguage,
        originalTitle,
        overview,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
        popularity
      ];
}
