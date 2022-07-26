import 'package:movieetlite/src/features/trends/domain/trend.dart';

abstract class ITrendsRepository {
  Future<List<Trend>?> fetchTrendMovies({required int page});
  Future<List<Trend>?> fetchTrendSeries({required int page});
}
