import 'package:json_annotation/json_annotation.dart';

import '../../0-core/base/model/base_model.dart';

part 'paginated_data.g.dart';

@JsonSerializable()
class PaginatedData extends BaseModel {
  int? page;
  dynamic results;
  int? totalPages;
  int? totalResults;
  PaginatedData({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory PaginatedData.fromJson(Map<String, dynamic> json) => _$PaginatedDataFromJson(json);
  @override
  PaginatedData fromJson(Map<String, dynamic> json) {
    return _$PaginatedDataFromJson(json);
  }

  @override
  Map<String, Object?> toJson() {
    return _$PaginatedDataToJson(this);
  }
}
