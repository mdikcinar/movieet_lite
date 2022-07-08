import 'package:chopper/chopper.dart';
import 'package:movieetlite/src/features/trends/domain/trend.dart';
import 'package:movieetlite/src/utils/constants/enums.dart';
import 'package:movieetlite/src/utils/domain/paginated_data.dart';

part 'trends_service.chopper.dart';

@ChopperApi()
abstract class TrendsService extends ChopperService {
  @Get(path: '/trending/{mediaType}/{timeWindow}')
  Future<Response<PaginatedData<Trend>>> getTrends(
    @Path() MediaType mediaType,
    @Path() TimeWindow timeWindow, {
    @Query('page') int? page,
    @Query('language') String? language,
    @Query('api_key') required String? apiKey,
  });

  static TrendsService create([ChopperClient? client]) {
    return _$TrendsService(client);
  }
}
