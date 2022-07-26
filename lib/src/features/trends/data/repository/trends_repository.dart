import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movieetlite/src/features/trends/data/repository/base_trends_repository.dart';
import 'package:movieetlite/src/features/trends/data/service/trends_service.dart';
import 'package:movieetlite/src/features/trends/domain/trend.dart';
import 'package:movieetlite/src/utils/constants/enums.dart';

class TrendsRepository extends ITrendsRepository {
  factory TrendsRepository(TrendsService trendsService) {
    _shared ??= TrendsRepository._sharedInstance(trendsService);
    return _shared!;
  }
  TrendsRepository._sharedInstance(this.trendsService);
  static TrendsRepository? _shared;

  final TrendsService trendsService;

  @override
  Future<List<Trend>?> fetchTrendMovies({required int page}) async {
    final result = await trendsService.getTrends(
      MediaType.movie,
      TimeWindow.week,
      apiKey: dotenv.env['API-KEY'],
      page: page,
    );
    return result.body?.results;
  }

  @override
  Future<List<Trend>?> fetchTrendSeries({required int page}) async {
    final result = await trendsService.getTrends(
      MediaType.tv,
      TimeWindow.week,
      apiKey: dotenv.env['API-KEY'],
      page: page,
    );
    return result.body?.results;
  }
}
