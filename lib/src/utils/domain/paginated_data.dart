import 'package:json_annotation/json_annotation.dart';
import 'package:movieetlite/src/core/base/model/base_model.dart';
import 'package:movieetlite/src/features/trends/domain/trend.dart';

part 'paginated_data.g.dart';

@JsonSerializable()
class PaginatedData<T> extends BaseModel<PaginatedData<T>> {
  PaginatedData({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory PaginatedData.fromJson(Map<String, dynamic> json) => _$PaginatedDataFromJson(json);
  int? page;
  int? totalPages;
  int? totalResults;
  @_Converter<T>()
  List<T>? results;

  @override
  PaginatedData<T> fromJson(Map<String, dynamic> json) {
    return _$PaginatedDataFromJson(json);
  }

  @override
  Map<String, Object?> toJson() {
    return _$PaginatedDataToJson(this);
  }
}

class _Converter<T> implements JsonConverter<T, Object?> {
  const _Converter();

  @override
  T fromJson(Object? json) {
    if (json is Map<String, dynamic> && json.containsKey('media_type')) {
      return Trend.fromJson(json) as T;
    }
    return json as T;
  }

  @override
  Object? toJson(T object) => object;
}
