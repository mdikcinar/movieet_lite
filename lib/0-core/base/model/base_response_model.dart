import 'base_error.dart';

abstract class IResponseModel<T> {
  T? data;
  IErrorModel? error;
}

class ResponseModel<T> extends IResponseModel<T> {
  ResponseModel({T? data, IErrorModel? error}) {
    data = this.data;
    error = this.error;
  }
}
