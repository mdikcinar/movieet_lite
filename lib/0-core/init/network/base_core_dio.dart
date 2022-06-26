import '../../base/model/base_model.dart';
import '../../base/model/base_response_model.dart';
import 'request_type_enum.dart';

abstract class ICoreDio {
  Future<IResponseModel<R>> send<R, T extends BaseModel>(String path,
      {required RequestType requestType,
      required T parseModel,
      dynamic data,
      Map<String, Object>? queryParameters,
      void Function(int, int)? onReceiveProgress});
}
