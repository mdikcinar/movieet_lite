// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedData _$PaginatedDataFromJson(Map<String, dynamic> json) =>
    PaginatedData(
      page: json['page'] as int?,
      results: json['results'],
      totalPages: json['totalPages'] as int?,
      totalResults: json['totalResults'] as int?,
    );

Map<String, dynamic> _$PaginatedDataToJson(PaginatedData instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'totalPages': instance.totalPages,
      'totalResults': instance.totalResults,
    };
