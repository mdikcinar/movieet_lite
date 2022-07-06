// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedData<T> _$PaginatedDataFromJson<T>(Map<String, dynamic> json) =>
    PaginatedData<T>(
      page: json['page'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map(_Converter<T>().fromJson)
          .toList(),
      totalPages: json['totalPages'] as int?,
      totalResults: json['totalResults'] as int?,
    );

Map<String, dynamic> _$PaginatedDataToJson<T>(PaginatedData<T> instance) =>
    <String, dynamic>{
      'page': instance.page,
      'totalPages': instance.totalPages,
      'totalResults': instance.totalResults,
      'results': instance.results?.map(_Converter<T>().toJson).toList(),
    };
