import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:movieetlite/src/core/network/json_serilizable_converter.dart';

class ChopperClientBuilder {
  static ChopperClient buildChopperClient(
    List<ChopperService> services, {
    http.BaseClient? httpClient,
    required String baseUrl,
  }) =>
      ChopperClient(
        client: httpClient,
        baseUrl: baseUrl,
        services: services,
        converter: JsonSerializableConverter(),
      );
}
