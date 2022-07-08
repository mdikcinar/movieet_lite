// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trends_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$TrendsService extends TrendsService {
  _$TrendsService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TrendsService;

  @override
  Future<Response<PaginatedData<Trend>>> getTrends(
      MediaType mediaType, TimeWindow timeWindow,
      {int? page, String? language, required String? apiKey}) {
    final $url = '/trending/${mediaType}/${timeWindow}';
    final $params = <String, dynamic>{
      'page': page,
      'language': language,
      'api_key': apiKey
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<PaginatedData<Trend>, Trend>($request);
  }
}
