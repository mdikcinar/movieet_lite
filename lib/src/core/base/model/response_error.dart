import 'package:json_annotation/json_annotation.dart';
import 'package:movieetlite/src/core/base/model/base_model.dart';

part 'response_error.g.dart';

@JsonSerializable()
class ResponseError extends BaseModel<ResponseError> {
  ResponseError({required this.errorStatus});

  factory ResponseError.fromJson(Map<String, dynamic> json) => _$ResponseErrorFromJson(json);
  final String errorStatus;
  @override
  ResponseError fromJson(Map<String, dynamic> json) {
    return _$ResponseErrorFromJson(json);
  }

  @override
  Map<String, Object?> toJson() {
    return _$ResponseErrorToJson(this);
  }
}
