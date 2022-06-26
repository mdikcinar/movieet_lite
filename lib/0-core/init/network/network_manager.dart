import 'package:dio/dio.dart';

import '../../constants/app_constants.dart';
import 'base_core_dio.dart';
import 'core_dio.dart';

class NetworkManager {
  static NetworkManager? _instance;
  static NetworkManager? get instance {
    _instance ??= NetworkManager._init();
    return _instance;
  }

  ICoreDio? coreDio;

  NetworkManager._init() {
    final baseOptions = BaseOptions(baseUrl: AppConstants.tmdbBaseApiUrl.value);

    coreDio = CoreDio(baseOptions);
  }
}
