import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import '../../base/model/base_error.dart';
import '../../base/model/base_model.dart';
import '../../base/model/base_response_model.dart';
import 'base_core_dio.dart';
import 'request_type_enum.dart';

part 'core_operations.dart';

class CoreDio with DioMixin implements Dio, ICoreDio {
  CoreDio(BaseOptions options) {
    this.options = options;
    interceptors.add(InterceptorsWrapper());
    httpClientAdapter = DefaultHttpClientAdapter();
  }

  @override
  Future<IResponseModel<R>> send<R, T extends BaseModel>(String path,
      {required RequestType requestType,
      required T parseModel,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      void Function(int, int)? onReceiveProgress}) async {
    final response = await request(path, data: data, options: Options(method: requestType.name));
    switch (response.statusCode) {
      case HttpStatus.ok:
      case HttpStatus.accepted:
        final model = _responseParser<R, T>(parseModel, response.data);
        return ResponseModel<R>(data: model);
      default:
        return ResponseModel(error: BaseError('message'));
    }
  }
}
