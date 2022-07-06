import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movieetlite/src/core/base/model/base_model.dart';

part 'trend.g.dart';

@JsonSerializable()
class Trend extends Equatable with BaseModel<Trend> {
  const Trend({
    this.adult,
    this.gender,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.knownForDepartment,
    this.title,
    this.mediaType,
    this.name,
    this.originCountry,
    this.originalLanguage,
    this.originalTitle,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.profilePath,
    this.releaseDate,
    this.firstAirDate,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.knownFor,
  });

  factory Trend.fromJson(Map<String, dynamic> json) => _$TrendFromJson(json);
  final bool? adult;
  @JsonKey(name: 'backdrop_path')
  final int? gender;
  final String? backdropPath;
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;
  final int? id;
  @JsonKey(name: 'known_for_department')
  final String? knownForDepartment;
  final String? title;
  @JsonKey(name: 'media_type')
  final String? mediaType;
  final String? name;
  @JsonKey(name: 'origin_country')
  final List<String>? originCountry;
  @JsonKey(name: 'original_language')
  final String? originalLanguage;
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  @JsonKey(name: 'original_name')
  final String? originalName;
  final String? overview;
  final double? popularity;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'profile_path')
  final String? profilePath;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @JsonKey(name: 'first_air_date')
  final String? firstAirDate;
  final bool? video;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'vote_count')
  final int? voteCount;
  @JsonKey(name: 'known_for')
  final List<Trend>? knownFor;

  @override
  Trend fromJson(Map<String, dynamic> json) {
    return _$TrendFromJson(json);
  }

  @override
  Map<String, Object?> toJson() {
    return _$TrendToJson(this);
  }

  @override
  List<Object?> get props => [
        adult,
        gender,
        backdropPath,
        genreIds,
        id,
        knownForDepartment,
        title,
        mediaType,
        name,
        originCountry,
        originalLanguage,
        originalTitle,
        originalName,
        overview,
        popularity,
        posterPath,
        profilePath,
        releaseDate,
        firstAirDate,
        video,
        voteAverage,
        voteCount,
        knownFor,
      ];
}
